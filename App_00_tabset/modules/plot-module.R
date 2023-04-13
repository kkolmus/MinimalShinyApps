module_plot_ui <- function(id, inTitle, inText){
  ns <- NS(id)
  
  tagList(
    
    div(
      id = ns(id),
      class = "panel",
      style = "height: 575px;",
      
      div(
        class = "panel-header text-center",
        h3(inTitle)
      ),
      
      div(
        column(
          width = 1,
          icon(
            name = "circle-info",
            class = "fa-2x",
            lib = "font-awesome"
          )
        ),
        column(
          width = 11,
          p(
            class = "text-primary",
            inText)
        )
      ),
      
      div(
        class = "panel-body",
        style = "padding-bottom: 65px;",
        plotOutput(outputId = ns("plot"))
      )
      
    )
    
  )
  
}


module_plot_server <- function(
    id, inData, inPlotFunction, inFeature1, inFeature2) {
  
  moduleServer(
    id = id,
    module = function(input, output, session){
      
      outplot <- reactive({
        inPlotFunction(
          inData = inData(), 
          inXaxislab = inFeature1(), 
          inYaxislab = inFeature2())
      })
      
      output$plot <- renderPlot(outplot())
      
    }
  )
}
