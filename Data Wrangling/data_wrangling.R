rm(list=ls())

library("dplyr")
library(tidyverse)
library("ggplot2")
library(stringr)

stress_levels_data <- read.csv("/Users/isaacyun/Documents/INFO201/project/actual data/StressLevelDataset.csv")

mental_health_data <- read.csv("/Users/isaacyun/Documents/INFO201/project/actual data/students_mental_health_survey.csv")

sleep_health_lifestyle <- read.csv("/Users/isaacyun/Documents/INFO201/project/actual data/sleep_health_lifestyle.csv")

# Converting column names to be the same

stress_levels_data <- stress_levels_data %>%
  rename(
    Anxiety_Score = anxiety_level,
    Stress_Level = stress_level,
    Depression_Score = depression,
    Sleep_Quality = sleep_quality,
    Extracurricular_Involvement = extracurricular_activities,
    School_Load = study_load,
    Social_Support = social_support,
    Academic_Performance = academic_performance,
    Basic_Needs = basic_needs
  )

mental_health_data <- mental_health_data %>%
  rename(
    School_Load = Semester_Credit_Load,
    Academic_Performance = CGPA
  )

# Converting categorical data from string values to numerical values on the same scale (1 - 5)

calculate_performance <- function(gpas) {
  performances <- c()
  for (x in 1:length(gpas)) {
    gpa = gpas[x]
    if (gpa > 3.8){
      performances <- c(performances, 5)
    }else if (gpa > 3.3){
      performances <- c(performances, 4)
    }else if (gpa > 2.8){
      performances <- c(performances, 3)
    }else if (gpa > 2.3){
      performances <- c(performances, 2)
    }else{
      performances <- c(performances, 1)
    }
  }
  return(performances)
}

calculate_good_avg_poor <- function(ftrs) {
  list <- c()
  for (x in 1:length(ftrs)) {
    ftr = ftrs[x]
    if (ftr == "Good"){
      list <- c(list, 5)
    }else if (ftr == "Average"){
      list <- c(list, 3)
    }else{
      list <- c(list, 1)
    }
  }
  return(list)
}

calculate_freq<- function(ftrs) {
  list <- c()
  for (x in 1:length(ftrs)) {
    ftr = ftrs[x]
    if (ftr == "Frequently"){
      list <- c(list, 5)
    }else if (ftr == "Occasionally"){
      list <- c(list, 3)
    }else{
      list <- c(list, 1)
    }
  }
  return(list)
}

calculate_high_mod_low <- function(ftrs) {
  list <- c()
  for (x in 1:length(ftrs)) {
    ftr = ftrs[x]
    if (ftr == "High"){
      list <- c(list, 5)
    }else if (ftr == "Moderate"){
      list <- c(list, 3)
    }else{
      list <- c(list, 1)
    }
  }
  return(list)
}
  
calculate_school_load <- function(creds) {
  list <- c()
  for (x in 1:length(creds)) {
    cred = creds[x]
    if (cred > 25){
      list <- c(list, 5)
    }else if (cred > 22){
      list <- c(list, 4)
    }else if (cred > 20){
      list <- c(list, 3)
    }else if (cred > 18){
      list <- c(list, 2)
    }else{
      list <- c(list, 1)
    }
  }
  return(list)
}

convert_scores <- function(scores){
  list <- c()
  for (x in 1:length(scores)){
    score = scores[x]
    if (score >= 20) {
      list <- c(list, 5)
    } else if (score > 15){
      list <- c(list, 4)
    } else if (score > 10) {
      list <- c(list, 3)
    } else if (score > 5) {
      list <- c(list, 2)
    } else {
      list <- c(list, 1)
    }
  }
  return(list)
}

# Calculating overall basic needs score based on financials, diet, and physical activity

calculate_basic_needs <- function(physicals, diets, finances) {
  list <- c()
  for (x in 1:length(physicals)) {
    phys = physicals[x]
    diet = diets[x]
    finance = 5 - finances[x]
    
    basic_score = round(mean(c(phys, diet, finance)), digits=0)
    list <- c(list, basic_score)
  }
  return(list)
}

# dropping NA values before conversions
mental_health_data <- mental_health_data[complete.cases(mental_health_data), ]

stress_levels_data <- stress_levels_data[complete.cases(stress_levels_data), ]

mental_health_data$Academic_Performance <- calculate_performance(mental_health_data$Academic_Performance)
mental_health_data$Sleep_Quality <- calculate_good_avg_poor(mental_health_data$Sleep_Quality)
mental_health_data$Physical_Activity <- calculate_high_mod_low(mental_health_data$Physical_Activity)
mental_health_data$Diet_Quality <- calculate_good_avg_poor(mental_health_data$Diet_Quality)
mental_health_data$Substance_Use <- calculate_freq(mental_health_data$Substance_Use)
mental_health_data$School_Load <- calculate_school_load(mental_health_data$School_Load)
mental_health_data$Social_Support <- calculate_high_mod_low(mental_health_data$Social_Support)
mental_health_data$Extracurricular_Involvement <- calculate_high_mod_low(mental_health_data$Extracurricular_Involvement)

mental_health_data$Basic_Needs <- calculate_basic_needs(physicals = mental_health_data$Physical_Activity, finances = mental_health_data$Financial_Stress, diets = mental_health_data$Diet_Quality)

stress_levels_data$Anxiety_Score <- convert_scores(stress_levels_data$Anxiety_Score)
stress_levels_data$Depression_Score <- convert_scores(stress_levels_data$Depression_Score)

mental_health_data <- mental_health_data %>%
  select(c("Academic_Performance", "Stress_Level", "Depression_Score", "Anxiety_Score", "Sleep_Quality", "Social_Support", "Extracurricular_Involvement", "School_Load", "Basic_Needs"))

stress_levels_data <- stress_levels_data %>%
  select(c("Academic_Performance", "Stress_Level", "Depression_Score", "Anxiety_Score", "Sleep_Quality", "Social_Support", "Basic_Needs", "Extracurricular_Involvement", "School_Load"))

student_health_data <- full_join(mental_health_data, stress_levels_data)

print(colnames(student_health_data))

# We'll be using left join to relate stress levels and sleep quality to potential sleep disorders, potential careers, and estimated durations of sleep

# First, we'll group the sleep/health/lifestyle dataset to be categorized by stress levels and sleep quality

# converting a 1-10 scale to a 1-5 scale similar to other datasets
convert_10_to_5<- function(qualities){
  list <- c()
  for (x in 1:length(qualities)){
    qual <- qualities[x]
    if (qual >= 8) {
      list <- c(list, 5)
    } else if (qual <= 4) {
      list <- c(list, 1)
    } else {
      list <- c(list, round(qual/2))
    }
  }
  return(list)
}

sleep_health_lifestyle <- sleep_health_lifestyle %>%
  rename(
    Stress_Level = Stress.Level,
    Sleep_Quality = Quality.of.Sleep,
    BMI = BMI.Category,
    Blood_Pressure = Blood.Pressure,
    Heart_Rate = Heart.Rate,
    Sleep_Disorder = Sleep.Disorder,
    Sleep_Duration = Sleep.Duration
  )

sleep_health_lifestyle$Stress_Level <- convert_10_to_5(sleep_health_lifestyle$Stress_Level)
sleep_health_lifestyle$Sleep_Quality <- convert_10_to_5(sleep_health_lifestyle$Sleep_Quality)

stress_level_df <- sleep_health_lifestyle %>%
  group_by(Stress_Level) %>%
  summarise(
    BMI.stress = names(sort(table(BMI), decreasing = TRUE))[1],
    Blood_Pressure.stress = names(sort(table(Blood_Pressure), decreasing = TRUE))[1],
    Heart_Rate.stress = names(sort(table(Heart_Rate), decreasing = TRUE))[1],
    Sleep_Disorder.stress = names(sort(table(Sleep_Disorder), decreasing = TRUE))[1],
    Sleep_Duration.stress = names(sort(table(Sleep_Duration), decreasing = TRUE))[1]
  )

sleep_qual_df <- sleep_health_lifestyle %>%
  group_by(Sleep_Quality) %>%
  summarise(
    BMI.sleep = names(sort(table(BMI), decreasing = TRUE))[1],
    Blood_Pressure.sleep = names(sort(table(Blood_Pressure), decreasing = TRUE))[1],
    Heart_Rate.sleep = names(sort(table(Heart_Rate), decreasing = TRUE))[1],
    Sleep_Disorder.sleep = names(sort(table(Sleep_Disorder), decreasing = TRUE))[1],
    Sleep_Duration.sleep = names(sort(table(Sleep_Duration), decreasing = TRUE))[1]
  )

student_health_data <- merge(student_health_data, stress_level_df, by="Stress_Level", all.x = TRUE)
student_health_data <- merge(student_health_data, sleep_qual_df, by="Sleep_Quality", all.x = TRUE)

# dropping NA values for clean data
student_health_data_pre_comb <- student_health_data[complete.cases(student_health_data), ]

# new columns for potential health qualities - combining prediction from sleep and stress
student_health_data <- student_health_data_pre_comb %>%
  mutate(
    BMI = map2(BMI.stress, BMI.sleep, ~c(.x, .y)),
    Blood_Pressure = map2(Blood_Pressure.stress, Blood_Pressure.sleep, ~c(.x, .y)),
    Heart_Rate = map2(Heart_Rate.stress, Heart_Rate.sleep, ~c(.x, .y)),
    Sleep_Duration = map2(Sleep_Duration.stress, Sleep_Duration.sleep, ~c(.x, .y)),
    Sleep_Disorder = map2(Sleep_Disorder.stress, Sleep_Disorder.sleep, ~c(.x, .y))
  )

convert_values_to_list <- function(col) {
  list <- c()
  for (x in 1:length(col)) {
    list <- c(list, col[x])
  }
  return(list)
}

student_health_data$Potential_BMI <- convert_values_to_list(student_health_data$BMI)
student_health_data$Potential_Blood_Pressure <- convert_values_to_list(student_health_data$Blood_Pressure)
student_health_data$Potential_Heart_Rate <- convert_values_to_list(student_health_data$Heart_Rate)
student_health_data$Potential_Sleep_Duration <- convert_values_to_list(student_health_data$Sleep_Duration)
student_health_data$Potential_Sleep_Disorder <- convert_values_to_list(student_health_data$Sleep_Disorder)

student_health_data <- student_health_data %>%
  select(c("Academic_Performance", "Stress_Level", "Depression_Score", 
           "Anxiety_Score", "Sleep_Quality", "Social_Support", "Basic_Needs",
           "Extracurricular_Involvement", "School_Load", "Potential_BMI", "Potential_Blood_Pressure",
           "Potential_Heart_Rate", "Potential_Sleep_Duration", "Potential_Sleep_Disorder"))


write.csv(student_health_data_pre_comb, "Data Wrangling/student_health_data.csv")

# Potential BMI/Sleep Disorder is a categorical variable
# Potential Blood_Pressure/Heart_Rate/Sleep_Duration is a numerical variable

# Summarized data takes a look at these different new variables in comparison to non-related conditions to find a potential relation

summarized <- student_health_data_pre_comb %>%
  group_by(Basic_Needs, Depression_Score, Anxiety_Score, School_Load, Social_Support) %>%
  summarise(
    Potential_BMI = names(sort(table(c(BMI.sleep, BMI.stress)), decreasing = TRUE))[1],
    Potential_Blood_Pressure = names(sort(table(c(Blood_Pressure.sleep, Blood_Pressure.stress)), decreasing = TRUE))[1],
    Potential_Heart_Rate = names(sort(table(c(Heart_Rate.sleep, Heart_Rate.stress)), decreasing = TRUE))[1],
    Potential_Sleep_Disorder = names(sort(table(c(Sleep_Disorder.sleep, Sleep_Disorder.stress)), decreasing = TRUE))[1],
    Potential_Sleep_Duration = names(sort(table(c(Sleep_Duration.sleep, Sleep_Duration.stress)), decreasing = TRUE))[1]
  )

# getting counts for the label

current_counter <- student_health_data %>%
  filter(Stress_Level >= 4)

print(nrow(current_counter))

haha <- read.csv("Data Wrangling/student_health_data.csv", check.names = TRUE)
