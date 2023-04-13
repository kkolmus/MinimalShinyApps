server <- function(input, output, session) {
  
  FeaturesForApp <- reactive({
    features
  })
  
  observe({
    featurechoices <- FeaturesForApp()
    
    updateSelectizeInput(
      session = session,
      inputId = "feature_1",
      choices = featurechoices,
      selected = "",
      server = TRUE)
    
    updateSelectizeInput(
      session = session,
      inputId = "feature_2",
      choices = featurechoices,
      selected = "",
      server = TRUE)
  }
  )
  
  Feature1 <- eventReactive(input$analyze, {
    input$feature_1
  })
  
  Feature1 <- eventReactive(input$analyze, {
    input$feature_2
  })
  
  observe({print(Feature1())})
  observe({print(Feature1())})
  
  output$plot.nr.1 <- renderPlot(
    {
      draw_blank_plot_with_a_comment(inText = "QC Plot # 1")
    }
  )
  
}