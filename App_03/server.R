server <- function(input, output, session) {

  visualization <-
    iris %>%
    dplyr::arrange(desc(Petal.Length)) %>%
    tibble::rownames_to_column(var = "Order") %>%
    dplyr::mutate(
      Order = as.numeric(Order),
      UX = ifelse(
        test = Species %in% c("setosa", "virginica"),
        yes = "Nice",
        no = "Ugly")) 
  
  output$plot <- renderPlot(
    
    expr = {
      
      ggplot(
        data = visualization,
        mapping = aes(
          x = Order, 
          y = Petal.Length,
          color = UX,
          fill = UX)) +
        geom_bar(
          stat = "identity") +
        coord_cartesian(
          xlim = ranges_plot$x, 
          expand = FALSE)
      
    }
    
  )
  
  ranges_plot <- reactiveValues(x = NULL)
  
  observeEvent(
    eventExpr = input$dblclick_plot, 
    handlerExpr = {
      brush <- input$brush_plot
      if (!is.null(brush)) {
        ranges_plot$x <- c(brush$xmin, brush$xmax)
      } else {
        ranges_plot$x <- NULL
      }
    })
  
  output$tooltip <- renderUI({
    
    req(visualization)
    req(input$hover_plot, nrow(visualization) > 0)
    
    point <- nearPoints(
      df = visualization, 
      input$hover_plot, 
      threshold = 50, 
      maxpoints = 1)
    
    if (nrow(point) == 0) return(NULL)
    
    wellPanel(
      p(
        HTML(
          paste0(
            "<b> Species: </b>",       point$Species,      "<br/>",
            "<b> Sepal Length: </b>",  point$Sepal.Length, "<br/>",
            "<b> Sepal Width: </b>",   point$Sepal.Width,  "<br/>",
            "<b> Petal Length: </b>",  point$Petal.Length, "<br/>",
            "<b> Petal Width: </b>",   point$Petal.Width,  "<br/>"
            )))
    )
  })
  
}
