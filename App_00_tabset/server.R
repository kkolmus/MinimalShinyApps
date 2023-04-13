server <- function(input, output, session) {
  
  RawDataForApp <- reactive({
    ds
  })
  
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
  
  Feature2 <- eventReactive(input$analyze, {
    input$feature_2
  })
  
  FeatureData <- eda_server(
    id = "eda",
    inFeature1 = Feature1,
    inFeature2 = Feature2,
    inRawData = RawDataForApp)
  
  targeted_analysis_server(
    id = "targeted_analysis",
    inFeature1 = Feature1,
    inFeature2 = Feature2,
    inSelectedData = FeatureData)
  
}
