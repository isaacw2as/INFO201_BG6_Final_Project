library(shiny)
library(ggplot2)
library(plotly)
library(dplyr)
library(readr) 


setwd("/Users/rowancooper/Desktop")
df <- read.csv("students_health_data.csv")

server <- function(input, output){
  
  #This is me trying to get continous variables out of physical ailments that we have in the data set. 
  
    df <- read_csv("students_health_data.csv") %>% # Update path as necessary
    mutate(
      Numerical_BMI = case_when(
        str_detect(Potential_BMI, "Normal") ~ 1,
        str_detect(Potential_BMI, "Overweight") ~ 2,
        str_detect(Potential_BMI, "Obese") ~ 3,
        TRUE ~ NA_real_
      ),
      Numerical_BP = case_when(
        str_detect(Potential_Blood_Pressure, "120/80") | str_detect(Potential_Blood_Pressure, "125/80") ~ 1,
        str_detect(Potential_Blood_Pressure, "130/85") ~ 2,
        str_detect(Potential_Blood_Pressure, "140/90") ~ 3,
        TRUE ~ NA_real_
      ),
      Numerical_HR = case_when(
        str_detect(Potential_Heart_Rate, "70") | str_detect(Potential_Heart_Rate, "68") ~ 1,
        str_detect(Potential_Heart_Rate, "85") ~ 2,
        TRUE ~ NA_real_
      )
    )
  
    

  output$viz_1_output <- renderPlotly({
    # Filter based on mental health factor and rating
    filtered_df <- df %>%
      filter(.data[[input$mental_health_factor]] == input$mental_health_rating)
    
    # Correcting the mapping of mental health factors to their actual column names in the dataset
    mental_health_factor_corrected <- switch(input$mental_health_factor,
                                             "Stress" = "Stress_Level",
                                             "Depression" = "Depression_Score",
                                             "Anxiety" = "Anxiety_Score")
    
    # Assuming 'Potential_BMI' selection maps to 'Numerical_BMI' etc.
    physical_health_factor <- switch(input$physical_health_factor,
                                     "Potential_BMI" = "Numerical_BMI",
                                     "Potential_Blood_Pressure" = "Numerical_BP",
                                     "Potential_Heart_Rate" = "Numerical_HR")
    
    # Filter the dataframe based on the corrected mental health factor
    filtered_df <- filtered_df %>%
      filter(.data[[mental_health_factor_corrected]] == input$mental_health_rating)
    
    # Prepare the data for plotting
    plot_data <- filtered_df %>%
      group_by(.data[[physical_health_factor]]) %>%
      summarise(Count = n(), .groups = 'drop')
    
    # Generate the plot
    viz_1_output <- ggplot(plot_data, aes(x = as.factor(.data[[physical_health_factor]]), y = Count, fill = as.factor(.data[[physical_health_factor]]))) +
      geom_bar(stat = "identity") +
      labs(title = paste("Distribution of", input$physical_health_factor, "for", input$mental_health_factor, "Level", input$mental_health_rating),
           x = input$physical_health_factor,
           y = "Count") +
      theme_minimal()
    
    ggplotly(viz_1_output)
  })
  
  
  
  output$viz_2_output <- renderPlotly({
    filtered_df <- df %>%  
      filter(.data[[input$user_selection_viz_2_1]]  == input$user_selection_viz_2_2)
    filtered_df 
    
    viz_2_output <- ggplot(data = NULL) + geom_bar(mapping = aes(
      x =   filtered_df[[input$user_selection_viz_2_3]]      ) )
    
    return(viz_2_output)   
  })
  
  
  output$viz_2_output <- renderPlotly({
    filtered_df <- df %>%  
      filter(.data[[input$user_selection_viz_2_1]]  == input$user_selection_viz_2_2)
    filtered_df 
    
    viz_2_output <- ggplot(data = NULL) + geom_bar(mapping = aes(
      x =   filtered_df[[input$user_selection_viz_2_3]]      ) )
    
    return(viz_2_output)   
  })
  
  output$viz_3_output <- renderPlotly({
    filtered_df <- df %>%
      filter(.data[[input$user_selection_viz_3_1]] == input$user_selection_viz_3_2)
    
    viz_3_output <- ggplot(filtered_df, aes(x = .data[[input$user_selection_viz_3_2]])) +
      geom_bar() +
      labs(title = "Mental and Social Health Factors", x = "Social Health Factor", y = "Count")
    
    ggplotly(viz_3_output)
  })
  
}

