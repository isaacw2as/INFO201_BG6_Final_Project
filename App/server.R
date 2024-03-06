library(shiny)
library(ggplot2)
library(plotly)
library(dplyr)
library(readr) 
library(stringr)


df <- read.csv("https://raw.githubusercontent.com/isaacw2as/INFO201_BG6_Final_Project/main/Data%20Wrangling/students_health_data.csv")

server <- function(input, output){

  output$viz_1_output <- renderPlotly({
    # Correcting the mapping of mental health factors to their actual column names in the dataset
    
    
    mental_health_factor_corrected <- switch(input$mental_health_factor,
                                             "Stress" = "Stress_Level",
                                             "Depression" = "Depression_Score",
                                             "Anxiety" = "Anxiety_Score")
    
    # Assuming 'Potential_BMI' selection maps to 'Numerical_BMI' etc.
    physical_health_factor <- switch(input$physical_health_factor,
                                     "Potential_BMI" = "NUM.Potential_BMI",
                                     "Potential_Blood_Pressure" = "NUM.Potential_BP",
                                     "Potential_Heart_Rate" = "NUM.Potential_HR")
    
    # Prepare the data for plotting
    plot_data <- df %>%
      filter(mental_health_factor_corrected == input$mental_health_rating) %>%
      group_by(.data[[physical_health_factor]]) %>%
      summarise(Count = n(), .groups = 'drop')
    
    # Generate the plot
    viz_1_output <- ggplot(plot_data, aes(x = as.factor(physical_health_factor), y = Count, fill = as.factor(physical_health_factor))) +
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

