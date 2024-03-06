library(plotly)

## OVERVIEW TAB INFO

overview_tab <- tabPanel("Overview Tab Title",
   h1("Some title"),
   p("some explanation")
)


## VIZ 1 TAB INFO

viz_1_sidebar <- sidebarPanel(
  h2("Select Mental Health/Physical Health Factors"),

    selectInput(inputId = "mental_health_factor", 
              label = "Select Mental Health Factor", 
              choices = c("Stress", "Depression", "Anxiety", "Sleep"),
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
              choices = c("BMI", "Blood Pressure", "Heart Rate"),
              selected = "BMI", 
              multiple = FALSE)
)


# Define the main panel for the first visualization
viz_1_main_panel <- mainPanel(
  h2("Finding the Most Common Physical Attributes for Mental Health Symptoms"),
  plotlyOutput(outputId = "viz_1_output")
)

# Combine the sidebar and main panel into a single tab
viz_1_tab <- tabPanel("Mental Health vs. Physical Health",
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
              multiple = FALSE)
)

viz_2_main_panel <- mainPanel(
  h2("Mental Health and Sleep"),
  plotlyOutput(outputId = "viz_2_output")
)

viz_2_tab <- tabPanel("Mental Health vs. Sleep",
  sidebarLayout(
    viz_2_sidebar,
    viz_2_main_panel
  )
)

## VIZ 3 TAB INFO


viz_3_sidebar <- sidebarPanel(
  h2("Select Mental Health/Social Health Factors"),
  
  # Slider input for selecting a mental health factor rating.
  
  sliderInput(inputId = "anxiety_selection", 
              label = "Anxiety Rating",
              value = 3, # Default value
              min = 0, # Minimum value
              max = 5, # Maximum value
              ticks = TRUE,
              step = 1), # Step size for the slider
  
  sliderInput(inputId = "depression_selection", 
              label = "Depression Rating",
              value = 3, # Default value
              min = 0, # Minimum value
              max = 5, # Maximum value
              ticks = TRUE,
              step = 1), # Step size for the slider
  
  sliderInput(inputId = "sleep_selection", 
              label = "Sleep Quality Rating",
              value = 3, # Default value
              min = 0, # Minimum value
              max = 5, # Maximum value
              ticks = TRUE,
              step = 1), # Step size for the slider  
  
  sliderInput(inputId = "stress_selection", 
              label = "Stress Rating",
              value = 3, # Default value
              min = 0, # Minimum value
              max = 5, # Maximum value
              ticks = TRUE,
              step = 1) # Step size for the slider
)

# Create the main panel for the third visualization where the new plot output will be displayed.
viz_3_main_panel <- mainPanel(
  h2("Finding Social Status for Students based on Mental Health Factors"),
  plotlyOutput(outputId = "viz_3_output") # Placeholder for the new Plotly output
)

# Combine the sidebar and main panel into a single tab panel for the third visualization.
viz_3_tab <- tabPanel("Mental Health vs. Social Health Factors",
  sidebarLayout(
    viz_3_sidebar,
    viz_3_main_panel
  )
)

viz_4_sidebar <- sidebarPanel(
  h2("Select Mental Health/Social Health Factors"),
  
  selectInput(inputId = "mental_selection", 
              label = "Mental Health Factor", 
              choices = c("Stress", "Depression", "Anxiety", "Sleep" ),
              selected = "Stress", 
              multiple = FALSE),
  
  selectInput(inputId = "social_selection",
              label = "Social Health Factor",
              choices = c("Academic Performance", "Basic Needs", "Extracurricular Involvement", "Social Support"),
              selected = "Academic Performance",
              multiple = FALSE)
)

viz_4_main_panel <- mainPanel(
  h2("Trends for Social Status based on Mental Health Factors"),
  plotlyOutput(outputId = "viz_4_output")
)

# Combine the sidebar and main panel into a single tab panel for the third visualization.
viz_4_tab <- tabPanel("Mental Health vs. Social Health Factors 2",
                      sidebarLayout(
                        viz_4_sidebar,
                        viz_4_main_panel
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
  viz_4_tab,
  conclusion_tab
)
