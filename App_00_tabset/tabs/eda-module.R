eda_ui <- function(id) {
  
  ns <- NS(id)
  
  tabPanel(
    
    title = "Summary of selected features",
    value = "summary_tab",
    p(class = "lead",
      style = "color: black; padding-top :20px;",
      "Results of exploratory data analysis."),
    
    module_data_table_ui(
      id = "feature_1_summary_table",
      inTitle = "Summary Table of Feature 1",
      inText =
        "This table shows summary statistics for feature 1."),
    
    module_data_table_ui(
      id = "feature_2_summary_table",
      inTitle = "Summary Table of Feature 2",
      inText =
        "This table shows summary statistics for feature 2.")
    
  )
  
}


eda_server <- function(
    id,
    inFeature1,
    inFeature2,
    inRawData) {
  
  FeaturesData <- reactive({
    
    req(inFeature1())
    req(inFeature2())
    req(inRawData())
    
    Feature1Data <- inRawData() %>% 
      dplyr::filter(Features %in% inFeature1())
      
    Feature2Data <- inRawData() %>% 
      dplyr::filter(Features %in% inFeature2())
    
    return(
      list(
        Feature1Data = Feature1Data,
        Feature2Data = Feature2Data 
      )
    )
    
  })
  
  module_data_table_server(
    id = "feature_1_summary_table",
    inData = FeaturesData,
    inSlot = "Feature1Data",
    inDataTableFunction = print_DT)
  
  module_data_table_server(
    id = "feature_2_summary_table",
    inData = FeaturesData,
    inSlot = "Feature2Data",
    inDataTableFunction = print_DT)
  
  FeaturesData
  
}
