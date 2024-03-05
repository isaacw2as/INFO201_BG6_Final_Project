library(plotly)

## OVERVIEW TAB INFO

overview_tab <- tabPanel("Overview Tab Title",
   h1("Some title"),
   p("some explanation")
)


## VIZ 1 TAB INFO

viz_1_sidebar <- sidebarPanel(
  h2("Mental Health Versus Physical Health"),

    selectInput(inputId = "mental_health_factor", 
              label = "Select Mental Health Factor", 
              choices = c("Stress", "Depression", "Anxiety"),
              selected = "Stress", 
              multiple = FALSE),
  
    sliderInput(inputId = "mental_health_rating", 
              label = "Mental Health Rating",
              min = 1, 
              max = 5, 
              value = 3, 
              step = 1,
              ticks = TRUE),
  
  selectInput(inputId = "physical_health_factor", 
              label = "Select Physical Health Factor", 
              choices = c("Potential_BMI", "Potential_Blood_Pressure", "Potential_Heart_Rate"),
              selected = "Potential_BMI", 
              multiple = FALSE)
)


# Define the main panel for the first visualization
viz_1_main_panel <- mainPanel(
  h2("Visualization 1 Title"),
  plotlyOutput(outputId = "viz_1_output")
)

# Combine the sidebar and main panel into a single tab
viz_1_tab <- tabPanel("Viz 1 tab title",
                      sidebarLayout(
                        viz_1_sidebar,
                        viz_1_main_panel
                      )
)



## VIZ 2 TAB INFO

viz_2_sidebar <- sidebarPanel(
  h2("Graph Options"),
  
  
  selectInput(inputId = "user_selection_viz_2_1", 
              label = "Mental Health Factor", 
              choices = c("Stress_Level", "Depression_Score", "Anxiety_Score" ),
              selected = "Stress_Level", 
              multiple = FALSE),
  
  sliderInput(inputId = "user_selection_viz_2_2", 
              label = "Mental Health Rating",
              value = 3,
              min = 0,
              max = 5,
              ticks = FALSE,
              #animate = TRUE, # Try this out to see what it does
              step = 1),
  
  selectInput(inputId = "user_selection_viz_2_3", 
              label = "Sleep Stats", 
              choices = c( "Potential_Sleep_Duration", "Potential_Sleep_Disorder", "Sleep_Quality"),
              selected = "Potential_Sleep_Duration", 
              multiple = FALSE),
)

viz_2_main_panel <- mainPanel(
  h2("Mental Health and Sleep"),
  plotlyOutput(outputId = "viz_2_output")
)

viz_2_tab <- tabPanel("Display 1: Mental Health and Sleep",
  sidebarLayout(
    viz_2_sidebar,
    viz_2_main_panel
  )
)



## VIZ 3 TAB INFO


viz_3_sidebar <- sidebarPanel(
  h2("Graph Options"),
  
  # Slider input for selecting a mental health factor rating.
  sliderInput(inputId = "user_selection_viz_3_1", 
              label = "Mental Health Factor Rating",
              value = 3, # Default value
              min = 0, # Minimum value
              max = 5, # Maximum value
              ticks = FALSE,
              step = 1), # Step size for the slider
  
  # Dropdown menu for selecting a social health factor.
  selectInput(inputId = "user_selection_viz_3_2", 
              label = "Social Health Factor", 
              choices = c("Academic_Performance", "Social_Support", "Basic_Needs", "Extracurricular_Involvement"),
              selected = "Academic_Performance", # Default selection
              multiple = FALSE),
)

# Create the main panel for the third visualization where the new plot output will be displayed.
viz_3_main_panel <- mainPanel(
  h2("Mental and Social Health Visualization"),
  plotlyOutput(outputId = "viz_3_output") # Placeholder for the new Plotly output
)

# Combine the sidebar and main panel into a single tab panel for the third visualization.
viz_3_tab <- tabPanel("Display 3: Mental and Social Health",
  sidebarLayout(
    viz_3_sidebar,
    viz_3_main_panel
  )
)


#/
#viz_3_sidebar <- sidebarPanel(
#  h2("Options for graph"),
#  #TODO: Put inputs for modifying graph here
#)

#viz_3_main_panel <- mainPanel(
#  h2("Vizualization 3 Title"),
  # plotlyOutput(outputId = "your_viz_1_output_id")
#)

#viz_3_tab <- tabPanel("Viz 3 tab title",
#  sidebarLayout(
#    viz_3_sidebar,
#    viz_3_main_panel
#  )
#)
#/

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
