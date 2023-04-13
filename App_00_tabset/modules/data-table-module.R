module_data_table_ui <- function(id, inTitle, inText){
  
  ns <- NS(id)
  
  tagList(
    
    div(
      id = ns(id),
      class = "panel",
      style = "height:auto;",
      
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
        DT::DTOutput(
          outputId = ns("data_table"))
      )
      
    )
    
  )
  
}


module_data_table_server <- function(id, 
                                     inData, 
                                     inSlot,
                                     inDataTableFunction = NULL) {
  moduleServer(
    id = id,
    module = function(input, output, session){
      
      summary_df <- reactive({
        inData()[[inSlot]]
      })
      
      output$data_table <- DT::renderDT( {
        inDataTableFunction(summary_df())
      })
      
    }
    
  )
  
}
