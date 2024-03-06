library(plotly)

## OVERVIEW TAB INFO

overview_tab <- tabPanel("Sleep, Academics, and Health",
                         h1("Introduction"),
                         p("The goal of this project is to seek out relationships between sleep and other factors.
     Doing this will allow us to determine whether our not there are any connections between the variables
     at play. For example, is there a correlation between people who report having high depression and those
     same people getting a low amount of sleep? From our datasets, we were able to gather information about
     numerous different aspects of a person's life."),
                         br(),
                         p("Among the variables present in the dataset, key ones are
     sleep quality, sleep disorders, depression score, anxiety score, and BMI. We hope to present some insights
     about the connections that can be made between all the different variables in our dataset. In particular,
     we were interested about the connection between mental health disorders and sleep quality, as well as how
     mental health relates to physical and social health, all of which should be relatable to most students."),
                         br(),
                         img( src = 'sleepimg.jpg', width = 300, align = "left"), 
                         img( src = 'hat.webp', width = 300, align = "center"),
                         img( src = 'health.jpg', width = 300, align = "right"),
                         br(),
                         h2("Dataset Information"),
                         p("The individual datasets that we used to create our final joined dataset came from these sources:"),
                         a(href = "https://www.kaggle.com/datasets/sonia22222/students-mental-health-assessments?resource=download", "Student Mental Health Assessments"),
                         br(),
                         a(href = "https://www.kaggle.com/datasets/rxnach/student-stress-factors-a-comprehensive-analysis", "Student Stress Factors"),
                         br(),
                         a(href = "https://datatools.samhsa.gov/saes/state", "SAMHSA Data"),
                         br(),
                         a(href = "https://www.cdc.gov/sleep/data-and-statistics/Adults.html", "CDC Data"),
                         br(),
                         h2("Data Limitations"),
                         p("Unfortunately, the data that we used comes with some limitations imposed on it, mainly due to
                           the first two datasets having origins that are somewhat obscure. However, this is mitigated by
                           the use of data from the CDC and SAMHSA, two government organizations that provide general data
                           about the population.")
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
              choices = c("Stress Level", "Depression", "Anxiety" ),
              selected = "Stress Level", 
              multiple = FALSE),
  
  sliderInput(inputId = "user_selection_viz_2_2", 
              label = "Mental Health Rating",
              value = 3,
              min = 0,
              max = 5,
              ticks = FALSE,
              animate = animationOptions(
                interval = 1500,
                loop = TRUE,
              ),  
              step = 1),
  
  
  selectInput(inputId = "user_selection_viz_2_3", 
              label = "Sleep Stats", 
              choices = c( "Sleep Duration", "Sleep Disorder", "Sleep Quality"),
              selected = "Sleep Duration", 
              multiple = FALSE)
)

viz_2_main_panel <- mainPanel(
  h2("Mental Health and Sleep"),
  plotlyOutput(outputId = "viz_2_output"),
 
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

conclusion_tab <- tabPanel("Conclusion",
                           h1("Conclusion of Mental Health on Physical, Mental, and Sleep Health:"),
                           p("We have combined datasets that link physical, mental, and sleep health to stress depression, and anxiety.
Using the data, we have created an interactive visualization showcasing how mental health disorders like anxiety, stress, and sleep quality impact our daily lives.
Our project encompasses three distinct visualizations focusing on physical health, mental health, and sleep health, each offering insights into how these
factors are interrelated and affect one another.

For example, one may witness in our first visualization how sleep quality affects physical health, and then move on to see how mental health affects sleep quality. 
In this sense, a new insight can be made connecting mental and physical health. One can also view in our third visualization how depression, anxiety, sleep quality
and stress all interplay into acieving various basic needs at differing levels of sucess. 

By bringing these three visualizations together, we aim to educate and raise awareness among students, a group particularly vulnerable to the pressures
of academic, social, and personal challenges. We hope that through showing how each of these disorders are connected with real data, we can bring awareness to the importance
of seeking mental help as we help clarify the clear evidential damage these disorders can have on physical, social, and mental well being.")
)



ui <- navbarPage("INFO 201 Final Project by Isaac Yun, Nicholas Wyatt, and Rowan Cooper",
                 overview_tab,
                 viz_1_tab,
                 viz_2_tab,
                 viz_3_tab,
                 viz_4_tab,
                 conclusion_tab
)





