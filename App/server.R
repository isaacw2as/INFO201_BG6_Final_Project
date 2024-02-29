
df <- read.csv("students_health_data.csv")

server <- function(input, output){
  
  output$viz_1_output <- renderPlotly({
      filtered_df <- df %>%  
          filter(.data[[input$user_selection_viz_1_1]]  == input$user_selection_viz_1_2)
       filtered_df 
         
      viz_1_output <- ggplot(data = NULL) + geom_bar(mapping = aes(
          x =   filtered_df[[input$user_selection_viz_1_3]]      ) )
        
      return(viz_1_output)   
  })
  
  
}
