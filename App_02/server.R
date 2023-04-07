server <- function(input, output, session) {
  X = data.frame(
    ID = c("Click here to jump to Tab2 and pass X=1 and Y=10 to Tab2", 
           "Click here to jump to Tab2 and pass X=2 and Y=9 to Tab2",
           "Click here to jump to Tab2 and pass X=3 and Y=8 to Tab2"),
    X = c(1,2,3),
    Y = c(10,9,8)    
  )
  
  output$datatable <- renderDataTable(
    
    expr = { X }, 
    
    selection = "single", 
    
    options = list(
      paging    = FALSE,
      searching = FALSE,
      filtering = FALSE,
      ordering  = FALSE)
    
  )
  
  observeEvent(input$datatable_rows_selected, {
    
    row <- input$datatable_rows_selected 
    
    output$text <- renderText(
      
      expr = { paste(
        "You clicked the following row: ", X[row, "ID"],
        ". Parameter x is: ", X[row, "X"], 
        ". Parameter x is: ", X[row, "Y"],
        ".") }
      
    )
    
    updateTabsetPanel(
      session = session, 
      inputId = "MainPanel", # id of tabsetPanel, no spaces
      selected = "Tab2")     # id of tabPanel, no spaces
    
  })  
}