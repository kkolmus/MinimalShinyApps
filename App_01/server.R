server <- function(input, output, session) {
  
  X = iris[c(1:5,50:55,100:105),]
  
  output$datatable <- renderDataTable(
    
    expr = { X }, 
    
    selection = "single",
    
    options = list(
      paging = FALSE,
      searching = FALSE,
      filtering = FALSE,
      ordering = FALSE)
    
  )
  
  observeEvent(
    
    eventExpr = input$datatable_rows_selected, 
    
    handlerExpr = {
      
      row <- input$datatable_rows_selected 
      
      output$text <- renderText(
        
        expr = { paste("The chosen species is", X[row, "Species"], sep = " ") } 
        
      )
      
      output$plot <- renderPlot(
        
        expr = {
          
          visualization <-
            data.frame(
              Sepal.Length = X[row, "Sepal.Length"],
              Sepal.Width  = X[row, "Sepal.Width"],
              Petal.Length = X[row, "Petal.Length"],
              Petal.Width  = X[row, "Petal.Width"]) %>%
            t() %>%
            as.data.frame() %>%
            magrittr::set_colnames("Length [cm]") %>%
            tibble::rownames_to_column(var = "Feature")
            
          print(visualization)
          
          ggplot(
            data = visualization,
            mapping = aes(
              x = Feature, 
              y = `Length [cm]`)) +
            geom_bar(
              stat = "identity") +
            coord_flip()
          
        }

      )
      
      updateTabsetPanel(
        
        session = session, 
        inputId = "Main Panel", # id of tabsetPanel
        selected = "Tab 2 - Selected data from table"
        
        )
      
      }
    
    )  
  
}
