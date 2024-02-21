library(tidyverse)
# https://www.datafiles.samhsa.gov/dataset/mental-health-client-level-data-2020-mh-cld-2020-ds0001

# STATE AND SUBSTANCE ABUSE
state_df <- read.csv("AdultState.csv") # https://www.cdc.gov/sleep/data-and-statistics/Adults.html
subabuse_df <- read.csv("SubstanceAbuse.csv") # https://datatools.samhsa.gov/saes/state

View(state_df)
View(subabuse_df) # estimate variable: Percentage of persons who are abusing pain relievers

state_df <- state_df %>% 
  rename(prevalence = Age.Adjusted.Prevalence....)

subabuse_df <- subabuse_df %>% 
  rename(State = state)

combined_df <- left_join(state_df, subabuse_df, by = 'State')

# Categorical variable - New column that makes it easy for both side of the confidence interval
# to be seen for the estimate of substance abuse value
combined_df <- combined_df %>% 
  mutate(estimate_confidence_interval = paste( round(ci_lower * 100, 3), " - ", round(ci_upper * 100, 3)))

# Quantitative variable - the median of the estimate of substance abuse confidence interval values
combined_df <- combined_df %>%  
  mutate(ci_median = round( ((ci_lower + ci_upper) / 2) * 100, 3))

# Summarization - Creates a summarization dataframe
summarization_df <- data.frame(unclass(summary(combined_df)))
# source: https://stackoverflow.com/questions/30520350/convert-summary-to-data-frame


write.csv(combined_df, "combined_df.csv", row.names = FALSE)
