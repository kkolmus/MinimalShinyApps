ui <- fluidPage(
  
  tabsetPanel(
    
        div(
          id = "App Header",
          class = "container",
          h1(
            class = "page-header",
            "Immediately update tab based on data table input",
            tags$small("Krzysztof Kolmus")),
          p(
            class = "lead",
            "Select a row from data table and jump to selected tab passing its values for summary and visualization in a different tab.
             This app can be modified to extract values from databases.
             This app can be modified to jump to a different tab upon clicking a button."),
        ),
    
    id = "MainPanel", 
    
    tabPanel(
      title = "Tab1",
      dataTableOutput("datatable")),
    
    tabPanel(
      title = "Tab2",
      textOutput("text"))
    
  )
  
)
