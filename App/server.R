
df <- read.csv("students_health_data.csv")

server <- function(input, output){
  
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
