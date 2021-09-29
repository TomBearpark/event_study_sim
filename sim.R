library(tidyverse);library(fixest)

## Simulation study, event study, multiple treatments per household

n_households <- 2000
n_zipcodes <- 7
n_T <- 100

hh <- 1:n_households
zc <- 1:n_zipcodes
T  <- 1:n_T

df <- 
  expand_grid(hh = hh, T = T) %>% 
  group_by(hh) %>%
    mutate(hh_fe = rnorm(1)) %>% 
    mutate(zc = sample(1:n_zipcodes, size = 1)) %>% 
  group_by(T) %>% 
    mutate(t_fe = T * rnorm(1)) %>% 
  ungroup() 

# Randomly select a set of zipcodes / 

df$treat <- 
  sample(c(rep(0, 100),1), size = length(df$hh), replace = TRUE)


