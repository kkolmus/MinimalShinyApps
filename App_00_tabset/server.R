server <- function(input, output, session) {
  
  # SELECT DATA ----
  
  RawDataForApp <- reactive({
    ds
  })
  
  FeaturesForApp <- reactive({
    features
  })
  
  # NEVER PUT HEAVY INPUT DATA FOR SELECTION TO UI, USE SERVER ----
  
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
  })
  
  # WHAT ARE WE GOING TO ANALYZE ----
  
  Feature1 <- eventReactive(input$analyze, {
    input$feature_1
  })
  
  Feature2 <- eventReactive(input$analyze, {
    input$feature_2
  })
  
  # SERVER MODEULES ----
  
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
