source("visualization_data.R")

# Define server function
server <- function(input, output) {

  # Page 1 plot code
  output$scatter_plot <- renderPlotly({
    plot_1_data_output <- filter(plot_1_data, cause == input$Cause_1) %>%
      filter(SDI.Index.Value > input$SDI[1] & SDI.Index.Value < input$SDI[2])

    # Code for Scatter Plot
    library(viridis)
    library(plotly)
    scatter_plot <- ggplot(plot_1_data_output,
                           aes(x = val, y = SDI.Index.Value)) +
      geom_point(aes(color = SDI.Index.Value, text = text)) +
      scale_color_viridis(option = "inferno") +
      scale_x_continuous(name = "Rate per 100,000 population") +
      scale_y_continuous(name = "SDI Index Value") +
      ggtitle("DALY Rate vs SDI Index Value
            for 402 locations in 2017") +
      theme_bw()
    return(ggplotly(scatter_plot, tooltip = "text"))
  })


  # Page 2 Plot Code
  output$histogram <- renderPlotly({
    plot_2_data_output <- plot_2_data %>%
      filter(year == input$Year & cause == input$Cause_2)

    # Code to make histogram
    histogram <- plot_ly(x = plot_2_data_output$val,
                         type = "histogram",
                         marker = list(color = viridis_pal(
                             option = "C",
                             direction = -1)(50)),
                         ) %>%
      layout(title = "Global Frequency Distribution of DALYs",
             xaxis = list(title = "DALYs per 100,000 people"),
             yaxis = list(title = "Frequency")) %>%
      add_trace(
        type = "histogram",
        mode = "lines+markers",
        hovertemplate =
        "Bin Range: %{x}\nFrequency: %{y}",
        showlegend = FALSE
      )
    return(histogram)
  })

  # Page 3 Plot Code
  output$line_graph <- renderPlotly({
    plot_3_data_output <- plot_3_data %>%
      filter(location == input$Location & cause == input$Cause_3)

    # Code for plot
    line_graph <- ggplot(plot_3_data_output, aes(x = Year, y = Rate)) +
      geom_line(color = "red", size = 1.5) +
      theme_bw() +
      labs(
        x = "Year", y = "DALY Rate per 100,000",
        title = "DALY Rate per 100,000 from 1990 - 2017"
      )
    return(line_graph)
  })
}
