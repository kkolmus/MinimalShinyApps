ui <- fluidPage(
  
  plotOutput(
    outputId = "plot",
    hover = "hover_plot",
    dblclick = "dblclick_plot",
    brush = brushOpts(
      id = "brush_plot",
      fill = "gray",
      stroke = "black",
      direction = "x",
      resetOnNew = TRUE)),
  
  uiOutput(
    outputId = "tooltip", 
    class = "well-tooltip")
  
)
