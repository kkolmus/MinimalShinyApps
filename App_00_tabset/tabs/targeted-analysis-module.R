targeted_analysis_ui <- function(id) {
  
  ns <- NS(id)
  
  tabPanel(
    
    title = "Correlation of selected features",
    value = "analysis_tab",
    p(class = "lead",
      style = "color: black; padding-top :20px;",
      "Results of correlation analysis."),
    
    module_plot_ui(
      id = "correlation_plot",
      inTitle = "Correlation analysis",
      inText =
        "This plot shows the relationship between feature 1 and feature 2.")
    
  )
  
}


targeted_analysis_server <- function(
    id,
    inFeature1,
    inFeature2,
    inSelectedData) {
  
  # ANY EXTRA ANALYSIS OR DATA PREPARATION ----
  
  SelectedData <- reactive({
    
    req(inSelectedData())
    
    SelectedInput <- inSelectedData()
    
    Feature1Data <- SelectedInput[["Feature1Data"]]
    Feature2Data <- SelectedInput[["Feature2Data"]]
    
    Dataset <- dplyr::full_join(Feature1Data, Feature2Data, by = c("Id", "Species"))
      
    return(Dataset)
    
  })
 
  # DATA VISUALIZATION AND SUMMARY MODULES ----
  
  module_plot_server(
    id = "correlation_plot",
    inData = SelectedData,
    inPlotFunction = draw_scatter_plot,
    inFeature1 = inFeature1,
    inFeature2 = inFeature2)
  
}
