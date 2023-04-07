ui <- fluidPage(
  
  tabsetPanel(
    
    id = "Main Panel", 
    
    div(
      id = "App Header",
      class = "container",
      h1(
        class = "page-header",
        "Update tab based on data table input",
        tags$small("Krzysztof Kolmus")),
      p(
        class = "lead",
        "Select a row from data table and pass its values for summary and visualization in a different tab.
         This app can be modified to extract values from databases.
         This app can be modified to jump to a different tab upon clicking a button."),
    ),
    
    tabPanel(
      
      title = "Tab 1 - Summary table",
      
      dataTableOutput("datatable")),
    
    tabPanel(
      
      title = "Tab 2 - Selected data from table",
      
      textOutput(outputId = "text"),
      
      plotOutput(outputId = "plot")
      
      )
    
  )
  
)
