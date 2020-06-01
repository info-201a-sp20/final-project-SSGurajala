intro_page <- tabPanel(
  title = "Intro",
  mainPanel(
    h1("Project Overview"),
    p("Sample Text"),
    h3("Cardiovascular Disease:"),
    img(src = "/images/cardiovascular_disease.jpg", alt = "Cardiovascular Disease"),
    h3("Respiratory Disease:"),
    img(src = "/images/respiratory_disease.jpg", alt = "Chronic Respiratory Disease"),
    h3("Neoplasm:"),
    img(src = "/images/neoplasm.jpg", alt = "Neoplasm")
  )
)

first_page <- tabPanel(
  title = "Page 1",
  sidebarPanel(
    h3("Input:")
  ),
  mainPanel(
    plotOutput(outputId = "")
  )
)
  
second_page <- tabPanel(
  title = "Page 2",
  sidebarPanel(
    h3("Input:")
  ),
  mainPanel(
    plotOutput(outputId = "")
  )
)
  
third_page <- tabPanel(
  title = "Page 3",
  sidebarPanel(
    h3("Input:")
  ),
  mainPanel(
    plotOutput(outputId = "")
  )
)

summary_page <- tabPanel(
  title = "Summary",
  mainPanel(
    p("Sample Text"),
    tableOutput("summary")
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


