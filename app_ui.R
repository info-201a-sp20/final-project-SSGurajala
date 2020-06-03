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
      exploring accordingly. The disability-adjusted life year (DALY) is our primary metric for disease 
      burden, and factors in years lost to ill-health, disability or early death. 
      This data was taken from the GHDx data selecting tool for the 2017 IHME Global Burden of Disease Study."),

    img(src = "images/mortality-from-ncds-sdgs.png", alt = "mortality map")
  )
)

first_page <- tabPanel(
  title = "SDI and DALYs",
  h1("How does income level/financial stability track with disease burden globally?"),
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
    p("This is a scatter plot that shows the correlation between
      SDI and population based on location. Users can pick a 
      cause and SDI range."),
    plotlyOutput(outputId = "scatter_plot")
  )
)

second_page <- tabPanel(
  title = "Distribution of DALY Rate",
  h1("How does disease burden differ between cardiovascular disease, chronic respiratory disease, 
       and neoplasms globally?"),
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
    p("This is a density distribution of DALY rates. Users can
      pick a year and cause."),
    plotOutput(outputId = "histogram")
  )
)

third_page <- tabPanel(
  title = "DALY by Location, 1990-2017",
  h1("How does disease burden for cardiovascular disease, chronic respiratory disease, 
       and neoplasms change over time?"),
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
    p("This graph shows DALY rate fluctuations between 1990 and
      2017. Users can pick location and cause."),
    plotlyOutput(outputId = "line_graph")
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
    img(src = "images/summary-1.png", alt = "plot 1"),
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
    img(src = "images/summary-2.png", alt = "plot 2"),
    h3("Changes of Three Diseases Over Time"),
    p("Generally, lines from plots are nearly horizontal, meaning that changes
      for the impact of three diseases were little from 1990 to 2017. As the
      graph shown below, the DALY rate of cardiovascular diseases and chronic
      respiratory diseases gained subtle decrease, while DALY rate of
      neoplasm did not change too much. Nevertheless, due to the lines position,
      we conclude that people have highest rate for getting cardiovascular
      diseases and lowest rate for getting chronic respiratory diseases among
      these three diseases."),
    img(src = "images/summary-3.png", alt = "plot 3")
  )
)

ui <- fluidPage(
  #includeCSS("style.css"),
  navbarPage(
    "Data Set Visualizations",
    intro_page,
    first_page,
    second_page,
    third_page,
    summary_page
  )
)
