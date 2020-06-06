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
    tags$a(href = "http://ghdx.healthdata.org/gbd-results-tool",
           "Global Disease Burden 2017 Study Data Source"),
    img(src = "images/mortality-from-ncds-sdgs.png", alt = "mortality map")
  )
)

first_page <- tabPanel(
  title = "Disease Burden V.S. Development",
  h2("How does income level/financial stability track with disease burden globally?"),
  sidebarPanel(
    h4("Input:"),
    feature_input <- selectInput(
      inputId = "Cause_1",
      label = "Selected Cause",
      choices = unique(plot_1_data$cause),
      selected = "Neoplasm"
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
    p("Socio-demographic Index (SDI) is an aggregate metric for
    development that factors in fertility, educational attainment,
    and income per capita. This scatter plot explores the 
    correlation between SDI and the DALY rate per 100,000 people 
    to identify possible impacts of a country's development on
    disease burden. Users can pick the disease and SDI range of 
    interest."),
    plotlyOutput(outputId = "scatter_plot")
  )
)

second_page <- tabPanel(
  title = "Distribution of DALY Rate",
  h2("How does disease burden differ between cardiovascular disease, chronic respiratory disease, 
       and neoplasms globally?"),
  sidebarPanel(
    h4("Input:"),
    year_input <- selectInput(
      inputId = "Year",
      label = "Selected Year",
      choices = unique(plot_2_data$year),
      selected = 2017
    ),
    feature_input <- selectInput(
      inputId = "Cause_2",
      label = "Selected Cause",
      choices = unique(plot_2_data$cause),
      selected = "Neoplasm"
    )
  ),
  mainPanel(
    p("This visualization seeks to understand the differences in
      experienced disease burden for the three diseases globally.
      This is accomplished by creating a histogram of DALY rate 
      values of all areas supplied in the Global Burden of
      Disease study. Users can supply their year and disease
      of interest."),
    plotlyOutput(outputId = "histogram")
  )
)

third_page <- tabPanel(
  title = "DALY by Location, 1990-2017",
  h2("How has disease burden from cardiovascular disease, chronic
  respiratory disease, and neoplasms changed over time?"),
  sidebarPanel(
    h4("Input:"),
    location_input <- selectInput(
      inputId = "Location",
      label = "Selected Location",
      choices = unique(plot_3_data$location),
      selected = "Global"
    ),
    feature_input <- selectInput(
      inputId = "Cause_3",
      label = "Selected Cause",
      choices = unique(plot_3_data$cause),
      selected = "Neoplasm"
    )
  ),
  mainPanel(
    p("This graph seeks to understand how disease burden for these
    three diseases has changed over the time period provided by the
    study. This is accomplished by using a line graph to show 
    fluctuations in DALY rate per 100,000 people from 1990 to 2017.
    Users can provide the location and cause of their choosing."),
    plotlyOutput(outputId = "line_graph")
  )
)

summary_page <- tabPanel(
  title = "Summary",
  mainPanel(
    h1("Our Data-Driven Questions"),
    h5(strong("How does income level/financial stability track with disease burden globally?")),
    h5(strong("How does disease burden differ between cardiovascular disease,
           chronic respiratory disease, and neoplasms globally?")),
    h5(strong("How does disease burden for cardiovascular disease, chronic respiratory
           disease, and neoplasms change over time?")),
    br(),
    h3("General Development V.S. Global Disease Burden"),
    p("In this graph, it seems that how developed a country is,
      as measured by SDI Index Value, doesn't have much of a
      bearing on the disease burden experienced per 100,000 people
      in that country. An exception to this may be neoplasms,
      which show a higher DALY rate at higher SDI Index values.
      This insight actually suggests that disease burden isn't
      particularly impacted by how developed a nation is, and that
      by and large people globally experience disease burden equally."),
    img(src = "images/scatter_plot_image.PNG", alt = "plot 1"),
    h3("Differences in Disease Burden on a Global Scale"),
    p("This chart reveals that countries experience the least
      disease burden from chronic respiratory diseases, more
      from cardiovascular diseases, and the most from neoplasms.
      Neoplasms have a distinct bimodal distribution, suggesting
      that countries either experience them at a lower rate
      (around 2,000 DALYs per 100,000 people) or a higher rate 
      (around 5,000 DALYs per 100,000 people). This insight
      suggests that for neoplasms, an external factor may exist
      that drives disease burden from neoplasms to be higher in
      certain countries. An in-depth analysis of the countries
      experiencing a higher disease burden from neoplasms could
      lead to disease burden alleviation for those populations."),
    img(src = "images/histogram_image.PNG", alt = "plot 2"),
    h3("Fluctuations in Disease Burden (1990-2017)"),
    p("These graphs reveal that, in general, global disease burden
      for these three diseases have declined steadily from about
      1990 to 2007. However, disease burden seems to be rising
      again for cardiovascular disease and neoplasms since 2007.
      This suggests that something is causing the prevalence and
      morbidity of these disease to increase in recent years.
      Further analysis would enable healthcare professionals and
      policy experts to better understand and combat the rising
      pressure these diseases are placing on population health."),
    img(src = "images/line_graph_image.PNG", alt = "plot 3")
  )
)

ui <- fluidPage(
  theme = "stylecss.css",
  navbarPage(
    "Chronic Disease Burden",
    intro_page,
    first_page,
    second_page,
    third_page,
    summary_page
  )
)
