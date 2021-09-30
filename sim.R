## Simulation study, event study, multiple treatments per household
# Want to check if this creates bias in the estimator 

library(tidyverse);library(fixest)
dir <- '/Users/tombearpark/Documents/GitHub/event_study_sim/'
source(paste0(dir, "funcs.R"))
set.seed(1)

# Set parameters 
leads <- 12
lags  <- 4
n_households <- 1000
n_zipcodes   <- 7
n_T          <- 100
beta <- c(seq(1,3, length.out = lags), seq(2,0.1, length.out = leads))^2
plot(beta)
treat_T   <- floor(median(T) / 2)
treat_hhs <- sample(hh, n_households / 10)

# Generate data
hh <- 1:n_households
zc <- 1:n_zipcodes
T  <- 1:n_T

df <- 
  expand_grid(hh = hh, T = T) %>% 
  group_by(hh) %>%
    mutate(hh_fe = rnorm(1)) %>% 
    mutate(zc = sample(1:n_zipcodes, size = 1)) %>% 
  group_by(T) %>% 
    mutate(t_fe = T/n_T + rnorm(1)) %>% 
  ungroup()  %>% 
  mutate(epsilon = rnorm(n()), 
         treat = 0, treat_effect = 0)

# 1. - create a single treatment that hits 1/10 of the zipcodes at 
### the same time, at the 25th time period. This one 
### should work nicely! 
df$treat <- ifelse(df$T == treat_T & df$hh %in% treat_hhs, 1, 0)
for(ii in 1:length(df$treat)){
  if(df$treat[ii] == 1){
    jj <- ii
    for(bb in beta){
      df$treat_effect[jj - 3] <- bb
      jj <- jj + 1
    }
  }
}

# Construct the outcome variable 
df$y <- df$hh_fe + df$t_fe + df$epsilon + df$treat_effect

# Plot a few time series; make sure data construction worked out
hh_draws <- c(sample(hh, 1), sample(treat_hhs, 1))
df %>% 
  filter(hh %in% hh_draws) %>% 
  ggplot(aes(group = hh)) + 
  geom_line(aes(x = T, y = y, color = hh))


# Subset to the columns available in a real world problem
reg_df <- df %>% 
  select(hh, T, treat, y)

# Add in dummies 
reg_df <- reg_df %>% 
  add_leads_lags(min = -4, max = 12) %>% 
  mutate(treat_0L = treat)
dums <- get_lags(exclude = -2, min = -lags, max = 12)

# Estimate by OLS
feols(data = reg_df, as.formula(paste0("y ~ ", dums))) %>% coefplot()
feols(data = reg_df, as.formula(paste0("y ~ ", dums, "| hh"))) %>% coefplot()
feols(data = reg_df, as.formula(paste0("y ~ ", dums, "| hh + T"))) %>% coefplot()

## Pretty good! 

# 2. - Add an extra treatment
