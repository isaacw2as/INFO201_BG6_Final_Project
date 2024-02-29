

## OVERVIEW TAB INFO

overview_tab <- tabPanel("Overview Tab Title",
   h1("Some title"),
   p("some explanation")
)

## VIZ 1 TAB INFO

viz_1_sidebar <- sidebarPanel(
  h2("Graph Options"),
  
  
  selectInput(inputId = "user_selection_viz_1_1", 
              label = "Mental Health Factor", 
              choices = c("Stress_Level", "Depression_Score", "Anxiety_Score" ),
              selected = "Stress_Level", 
              multiple = FALSE),
  
  sliderInput(inputId = "user_selection_viz_1_2", 
              label = "Mental Health Rating",
              value = 3,
              min = 0,
              max = 5,
              ticks = FALSE,
              #animate = TRUE, # Try this out to see what it does
              step = 1),
  
  selectInput(inputId = "user_selection_viz_1_3", 
              label = "Physical Health Factor", 
              choices = c("Potential_BMI", "Potential_Blood_Pressure", "Potential_Heart_Rate", "Potential_Sleep_Duration", "Potential_Sleep_Disorder"  ),
              selected = "Potential_BMI", 
              multiple = FALSE),
)

viz_1_main_panel <- mainPanel(
  h2("Mental Health and Physicals"),
  plotlyOutput(outputId = "viz_1_output")
)

viz_1_tab <- tabPanel("Display 1: Mental Health and Physicals",
  sidebarLayout(
    viz_1_sidebar,
    viz_1_main_panel
  )
)

## VIZ 2 TAB INFO

viz_2_sidebar <- sidebarPanel(
  h2("Options for graph"),
  #TODO: Put inputs for modifying graph here
)

viz_2_main_panel <- mainPanel(
  h2("Vizualization 2 Title"),
  # plotlyOutput(outputId = "your_viz_1_output_id")
)

viz_2_tab <- tabPanel("Viz 2 tab title",
  sidebarLayout(
    viz_2_sidebar,
    viz_2_main_panel
  )
)

## VIZ 3 TAB INFO

viz_3_sidebar <- sidebarPanel(
  h2("Options for graph"),
  #TODO: Put inputs for modifying graph here
)

viz_3_main_panel <- mainPanel(
  h2("Vizualization 3 Title"),
  # plotlyOutput(outputId = "your_viz_1_output_id")
)

viz_3_tab <- tabPanel("Viz 3 tab title",
  sidebarLayout(
    viz_3_sidebar,
    viz_3_main_panel
  )
)

## CONCLUSIONS TAB INFO

conclusion_tab <- tabPanel("Conclusion Tab Title",
 h1("Some title"),
 p("some conclusions")
)



ui <- navbarPage("Example Project Title",
  overview_tab,
  viz_1_tab,
  viz_2_tab,
  viz_3_tab,
  conclusion_tab
)