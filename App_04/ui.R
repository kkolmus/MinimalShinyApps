ui <- fluidPage(
  
  plotOutput(
    outputId = "plot",
    hover = "hover_plot"),
  
  uiOutput(
    outputId = "tooltip", 
    class = "well-tooltip")
  
)
