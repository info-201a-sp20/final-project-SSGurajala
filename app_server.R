source("visualization_data.R")

# Define server function
server <- function(input, output) {
  
  #Page 1 plot code 
  output$scatter_plot <- renderPlotly({
    
    plot_1_data_output <- filter(plot_1_data, cause == input$Cause_1) %>%
    filter(SDI.Index.Value > input$SDI[1] & SDI.Index.Value < input$SDI[2])
    
    #Code for Scatter Plot
    library(viridis)
    library(plotly)
    scatter_plot <- ggplot(plot_1_data_output, aes(x = val, y = SDI.Index.Value)) +
      geom_point(aes(color = SDI.Index.Value, text = text)) +
      scale_color_viridis(option = "inferno") +
      scale_x_continuous(name = "Rate per 100,000 population") +
      scale_y_continuous(name = "SDI Index Value") +
      ggtitle("DALY Rate vs SDI Index Value
            for 402 locations in 2017") +
      theme_bw()
    if(input$boxinput1) {
      plot_1_data_output_box <- plot_1_data %>%
        filter(SDI.Index.Value > input$SDI[1] &
                 SDI.Index.Value < input$SDI[2])
      scatter_plot <- ggplot(plot_1_data_output_box, aes(x = val, y = SDI.Index.Value)) +
        geom_point(aes(color = SDI.Index.Value)) +
        scale_color_viridis(option = "inferno") +
        scale_x_continuous(name = "Rate per 100,000 population") +
        scale_y_continuous(name = "SDI Index Value") +
        ggtitle("DALY Rate vs SDI Index Value
            for 402 locations in 2017") +
        facet_wrap(~cause) +
        theme_bw()
      }
    return(ggplotly(scatter_plot, tooltip = "text"))
  })
  
  
  #Page 2 Plot Code
  output$histogram <- renderPlot({
    
    plot_2_data_output <- plot_2_data %>%
      filter(year == input$Year & cause == input$Cause_2)
    
    #Code to make histogram 
    histogram <- ggplot(plot_2_data_output, aes(x = val)) +
      geom_histogram(
        binwidth = 200, aes(y = ..density..),
        color = "black", fill = "white"
      ) +
      geom_density(alpha = 0.3, fill = "#FF6666") +
      geom_vline(aes(xintercept = mean(val))) +
      labs(
        title = "Density Distribution of DALY Rate per 100,000",
        x = "DALY rate per 100,000",
        y = "Density"
      ) +
      theme_bw()
    if(input$boxinput2) {
      plot_2_data_output_box <- plot_2_data %>%
        filter(year == input$Year)
      histogram <- ggplot(plot_2_data_output_box, aes(x = val)) +
        geom_histogram(
          binwidth = 200, aes(y = ..density..),
          color = "black", fill = "white"
        ) +
        geom_density(alpha = 0.3, fill = "#FF6666") +
        geom_vline(aes(xintercept = mean(val))) +
        labs(
          title = "Density Distribution of DALY Rate per 100,000",
          x = "DALY rate per 100,000",
          y = "Density"
        ) +
        facet_wrap(~cause) +
        theme_bw() + 
        theme(legend.position = "none")
    }
    return(histogram)
  })
  
  #Page 3 Plot Code 
  output$line_graph <- renderPlotly({
    
    plot_3_data_output <- plot_3_data %>%
      filter(location == input$Location & cause == input$Cause_3)
    
    #Code for plot 
    line_graph <- ggplot(plot_3_data_output, aes(x = year, y = val)) +
      geom_line(color = "red", size = 1.5) +
      theme_bw() +
      labs(x = "Year", y = "DALY Rate per 100,000",
           title = "DALY Rate per 100,000 from 1990 - 2017")
    if(input$boxinput3) {
      plot_3_data_output_box <- plot_3_data %>%
        filter(location == input$Location)
      line_graph <- ggplot(plot_3_data_output_box, aes(x = year, y = val)) +
        geom_line(color = "red", size = 1.5) +
        labs(x = "Year", y = "DALY Rate per 100,000",
             title = "DALY Rate per 100,000 from 1990 - 2017") +
        facet_wrap(~cause) +
        theme_bw()
    }
    return(line_graph)
  })
}
  




