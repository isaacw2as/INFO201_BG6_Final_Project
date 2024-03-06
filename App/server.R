library(shiny)
library(ggplot2)
library(plotly)
library(dplyr)
library(readr) 
library(stringr)
library(tidyr)
 


df <- read.csv("https://raw.githubusercontent.com/isaacw2as/INFO201_BG6_Final_Project/main/Data%20Wrangling/student_health_data.csv")

server <- function(input, output){

  output$viz_1_output <- renderPlotly({
    # Correcting the mapping of mental/physical health factors to their actual column names
    mental_health_factor<- switch(input$mental_health_factor,
                                             "Stress" = "Stress_Level",
                                             "Depression" = "Depression_Score",
                                             "Anxiety" = "Anxiety_Score",
                                             "Sleep" = "Sleep_Quality")
    
    physical_health_factor <- if (input$mental_health_factor == "Sleep") {
      switch(input$physical_health_factor,
             "BMI" = "BMI.sleep",
             "Blood Pressure" = "Blood_Pressure.sleep",
             "Heart Rate" = "Heart_Rate.sleep")
    } else {
      switch(input$physical_health_factor,
             "BMI" = "BMI.stress",
             "Blood Pressure" = "Blood_Pressure.stress",
             "Heart Rate" = "Heart_Rate.stress")
    }
    
    
    # Prepare the data for plotting
    plot_data <- df %>%
      filter(.data[[mental_health_factor]] == input$mental_health_rating) %>%
      group_by(.data[[physical_health_factor]]) %>%
      summarise(Count = n(), .groups = 'drop')
    
    # Generate the plot
    viz_1_output <- ggplot(data = plot_data, aes_string(x = physical_health_factor, y = "Count")) +
      geom_col() + 
      labs(
        title="Most Apparent Physical Health Factors",
        x="Count",
        y=input$physical_health_factor
      )
    
    ggplotly(viz_1_output)
    
  })
  
  output$viz_2_output <- renderPlotly({
    user_selection_viz_2_1 <- switch(input$user_selection_viz_2_1,
           "Stress Level" = "Stress_Level",
           "Depression" = "Depression_Score",
           "Anxiety" = "Anxiety_Score")
    
    user_selection_viz_2_3 <- switch(input$user_selection_viz_2_3,
                            "Sleep Duration" = "Sleep_Duration.sleep",
                            "Sleep Disorder" = "Sleep_Disorder.sleep", 
                            "Sleep Quality" = "Sleep_Quality")
    
    filtered_df <- df %>%  
      filter(.data[[user_selection_viz_2_1]] == input$user_selection_viz_2_2)
 
    X <- filtered_df[[user_selection_viz_2_3]]
    
    viz_2_output <- ggplot(data = NULL) + geom_bar(mapping = aes(
      x =  X ,fill = as.factor(X)) ) + 
      labs(title = "Mental Health & Relation to Sleep Disorders and Sleep Quality",
           x = paste("Sleep Factor:", input$user_selection_viz_2_3),
           y = "Count",
           fill = "Key") +
      theme_bw()
  
    
     ggplotly(viz_2_output, tooltip = c("x","y")) 
  })
  
  
   
  
  
  output$viz_3_output <- renderPlotly({
    filtered_df <- df %>%
      filter(Stress_Level == input$stress_selection) %>%
      filter(Sleep_Quality == input$sleep_selection) %>%
      filter(Depression_Score == input$depression_selection) %>%
      filter(Anxiety_Score == input$anxiety_selection)
    
    filtered_df <- filtered_df %>%
      summarize(academic = mean(Academic_Performance),
                social = mean(Social_Support),
                basic = mean(Basic_Needs),
                extras = mean(Extracurricular_Involvement))
    
    filtered_df_long <- pivot_longer(filtered_df, cols = c(academic, social, basic, extras), names_to = "Variable", values_to = "Value")
    
    viz_3_output <- ggplot(filtered_df_long, aes(x = Variable, y = Value, fill = Variable)) +
      geom_bar(stat = "identity") +
      theme_minimal() +
      labs(title = "Social Factor Scores Based on Mental Health Factors Selected",
           x = "Social Factors",
           y = "Average Score",
           fill = "Social Factors") +
      scale_x_discrete(labels = c(
        "academic" = "Academic Performance",
        "social" = "Social Support",
        "basic" = "Basic Needs",
        "extras" = "Extracurricular Involvement"
      ))
    
    ggplotly(viz_3_output)
  })
  
  output$viz_4_output <- renderPlotly({
    
    mental_health_factor <- switch(input$mental_selection,
                                   "Stress" = "Stress_Level",
                                   "Depression" = "Depression_Score",
                                   "Anxiety" = "Anxiety_Score",
                                   "Sleep" = "Sleep_Quality")
    
    social_health_factor <- switch(input$social_selection,
                                   "Academic Performance" = "Academic_Performance",
                                   "Basic Needs" = "Basic_Needs",
                                   "Extracurricular Involvement" = "Extracurricular_Involvement",
                                   "Social Support" = "Social_Support")
    
    filtered_df <- df %>%
      group_by(.data[[mental_health_factor]]) %>%
      summarize(mean = mean(.data[[social_health_factor]], na.rm = TRUE), .groups = 'drop')
    
    viz_4_output <- ggplot(data = filtered_df) +
      geom_line(mapping = 
                  aes(x = .data[[mental_health_factor]],
                      y = mean))
    
    ggplotly(viz_4_output)
  })
  
}

