source("visualization_data.R")

intro_page <- tabPanel(
  title = "Intro",
  mainPanel(
    h1("Project Overview"),
    p(""),
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
    plotlyOutput(outputId = "scatter_plot")
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
    p("In general, we found that most points form scatter plot gather together
      at the upper left corner (higher SDI Index Value and lower rate of
      population). As shown in the graph below, most locations that have
      relatively lower rate of population for three diseases have relatively
      higher SDI values. Such observation shows that the rate of patients
      with those three diseases is lower in area with more advanced
      development."),
    img(src = "/images/summary_image_1.png", alt = "plot 1"),
    h3("Differences between Three Diseases on Impacts in Global Scale"),
    p("With respect to years, each disease has its own pattern on density of
      DALY rate. In specific, the peek of density of DALY rate of cardiovascular
      disease is around 5000 DALY rate per 100,000 (2000 DALY rate for chronic
      respiratory diseases and two peeks at 2500 and 5000 DALY rate for
      neoplasms). At the graph below, which we selected year 2017, three plots
      clearly show the pattern we described. Such patterns infer that although
      fewer people get chronic respiratory diseases than two other diseases,
      their lives are much shorter than patients get influenced by two other
      diseases."),
    img(src = "/images/summary_image_2.png", alt = "plot 2"),
    h3("Changes of Three Diseases Over Time"),
    p("Generally, lines from plots are nearly horizontal, meaning that changes
      for the impact of three diseases were little from 1990 to 2017. As the
      graph shown below, the DALY rate of cardiovascular diseases and chronic
      respiratory diseases gained subtle decrease, while DALY rate of
      neoplasm did not change too much. Nevertheless, due to the lines position,
      we conclude that people have highest rate for getting cardiovascular
      diseases and lowest rate for getting chronic respiratory diseases among
      these three diseases."),
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


