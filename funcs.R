add_leads_lags <- function(df, min, max){
  
  df <- df %>% group_by(hh) %>% 
    arrange(T, .by_group = TRUE)
  
  for(i in min:max){
    print(i)
    if(i == 0) {
      next
    }else if(i < 0) {
      df <- df %>% mutate("treat_{{i}}"  := lag(treat, n = -i))
    }else if(i > 0){
      df <- df %>% mutate("treat_{{i}}"  := lead(treat, n = i))
    }
  }
  names(df) <- str_replace(names(df), '"',"" )
  names(df) <- str_replace(names(df), '"',"" )
  df %>% 
    arrange(T, .by_group = TRUE) %>% 
    ungroup() 
}
get_lags <- function(exclude, min, max){
  dums <- ""
  for(i in min:max) {
    if(i == exclude) next
    dums <- paste0(dums, "+ `treat_", i, "L`")
  }
  dums
}
