source("visualization_data.R")

intro_page <- tabPanel(
  title = "Intro",
  mainPanel(
    h1("Project Overview"),
    p("The acute nature of infectious disease often draws our attention because of 
      the imminent pain and suffering they bring to millions around the globe, as 
      seen by the current Coronavirus pandemic. However, the physical and mental 
      impact of non-infectious chronic diseases can also be overwhelming to patients, 
      and should not be ignored. In our project, we focused primarily on how chronic 
      non-infectious diseases have infected or continue to infect the lives of people 
      around the world. So we picked 3 diseases: cardiovascular disease, respitory 
      disease, and neoplasm, and raised three questions that we are interested in 
      exploring accordingly."),
    h3("Questions Raised:"),
    h4("How does income level/financial stability track with disease burden globally?"),
    p("We want to use the dataset's metric of Social Demographic Index (SDI) to determine 
      income level and general prosperity and pair that with disability-adjusted life years, 
      years of life lost to disease, and mortality data to see trends in disease burden and prosperity"), 
    h4("How does disease burden differ between cardiovascular disease, chronic respiratory disease, 
       and neoplasms globally?"),
    p("We want to use the metrics of disability-adjusted life years, years of life lost to disease, 
      and mortality data to assess disease burden of each disease at the data's most current time, 2017, 
      and do comparative analyses between the results for each of these diseases."),
    h4("How does disease burden for cardiovascular disease, chronic respiratory disease, 
       and neoplasms change over time?"),
    p("We want to track disease burden over time by analyzing changes in disability-adjusted life years, 
      years of life lost, and mortality data for each of these diseases over the period 1990 to 2017."),
    h3("Cardiovascular Disease:"),
    img(src = "/images/cardiovascular_disease.jpg", alt = "Cardiovascular Disease"),
    h3("Respiratory Disease:"),
    img(src = "/images/respiratory_disease.jpg", alt = "Chronic Respiratory Disease"),
    h3("Neoplasm:"),
    img(src = "/images/neoplasm.jpg", alt = "Neoplasm")
  )
)

first_page <- tabPanel(
  title = "SDI and DALYs",
  sidebarPanel(
    h3("Input:"),
    feature_input <- selectInput(
      inputId = "Cause_1",              
      label = "Selected Cause",
      choices = unique(plot_1_data$cause),
      selected = "Neoplasm"
    ), 
    checkboxInput(
      inputId = "boxinput1", 
      label = "Show All Causes", 
      value = FALSE
      ),
    SDI_input <- sliderInput(
      inputId = "SDI",
      label = "Selected SDI",
      min = min(plot_1_data$SDI.Index.Value, na.rm = TRUE),
      max = max(plot_1_data$SDI.Index.Value, na.rm = TRUE),
      value = range(plot_1_data$SDI.Index.Value)
    )
  ),
  mainPanel(
    plotOutput(outputId = "scatter_plot")
  )
)
  
second_page <- tabPanel(
  title = "Distribution of DALY Rate",
  sidebarPanel(
    h3("Input:"),
    year_input <- selectInput(
      inputId = "Year",              
      label = "Selected Year",
      choices = unique(plot_2_data$year),
      selected = 2017
    ),
    checkboxInput(
      inputId = "boxinput2", 
      label = "Show All Causes", 
      value = FALSE
    ),
    feature_input <- selectInput(
      inputId = "Cause_2",              
      label = "Selected Cause",
      choices = unique(plot_2_data$cause),
      selected = "Neoplasm"
    )
  ),
  mainPanel(
    plotOutput(outputId = "histogram")
  )
)
  
third_page <- tabPanel(
  title = "DALY by Location, 1990-2017",
  sidebarPanel(
    h3("Input:"),
    location_input <- selectInput(
      inputId = "Location",              
      label = "Selected Location",
      choices = unique(plot_3_data$location),
      selected = "Global"
    ),
    checkboxInput(
      inputId = "boxinput3", 
      label = "Show All Causes", 
      value = FALSE
    ),
    feature_input <- selectInput(
      inputId = "Cause_3",              
      label = "Selected Cause",
      choices = unique(plot_3_data$cause),
      selected = "Neoplasm"
    )
  ),
  mainPanel(
    plotOutput(outputId = "line_graph")
  )
)

summary_page <- tabPanel(
  title = "Summary",
  mainPanel(
    h2("Our Data Driven Questions"),
    h5(strong("How does income level/financial stability track with disease burden globally?")),
    h5(strong("How does disease burden differ between cardiovascular disease,
           chronic respiratory disease, and neoplasms globally?")),
    h5(strong("How does disease burden for cardiovascular disease, chronic respiratory
           disease, and neoplasms change over time?")),
    h3("Income Level/Financial Stability V.S. Disease Burden Globally"),
    p("As shown in the graph below, most locations that have relatively lower
      rate of population for three diseases have relatively higher SDI values.
      Such observation shows that the rate of patients with those three diseases is
      lower in area with more advanced development."),
    img(src = "/images/summary_image_1.png", alt = "plot 1"),
    h3("Differences between three diseases on impacts in global scale"),
    p("In the graph "),
    img(src = "/images/summary_image_2.png", alt = "plot 2"),
    h3("changes of three diseases over time"),
    p(""),
    img(src = "/images/summary_image_3.png", alt = "plot 3")
  )
)

ui <- fluidPage(
  navbarPage(
    "Data Set Visualizations",
    intro_page,
    first_page,
    second_page,
    third_page,
    summary_page
  )
)


