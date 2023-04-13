ui <- fluidPage(
  
  title = "Iris Dataset Explorer",
  
  shinythemes::themeSelector(),  # <--- Add this somewhere in the UI
  # theme = shinythemes::themeSelector("name_of_style")

  div(
    id = "app_header",
    class = "container",
    h1(
      class = "page-header",
      "Iris Dataset Explorer",
      tags$small("Theophrastus of Eresos")),
    p(
      class = "lead",
      "This web application visualizes features of flowers stored within the Iris dataset."
    )
  ),
  
  div(
    
    id = "sidebarLayout",
    class = "container",
    
    column(
      
      id = "sidebarPanel",
      
      width = 4,
      
      wellPanel(
        
        input_selector_ui(
          id = "feature_1_selector", 
          inIconName = "flower", 
          inInputId = "feature_1", 
          inLabel = "Feature 1 (Pick a Feature to Analyze)", 
          inComingInput = NULL),
        
        input_selector_ui(
          id = "feature_2_selector", 
          inIconName = "flower", 
          inInputId = "feature_2", 
          inLabel = "Feature 1 (Pick a Feature to Analyze)", 
          inComingInput = NULL),
        
        # ACTION BUTTON ----
        div(
          class = "text-center",
          actionButton(
            inputId = "analyze",
            label = "Analyze",
            icon = icon(
              name = "magnifying-glass",
              class = "fa-1x",
              lib = "font-awesome"
            )
          )
        )
      )
    ),
    
    column(
      
      id = "mainPanel",
      width = 8,
      
      tabsetPanel(
        
        id = "app_analysis",
        type = "tabs",
        
        tabPanel(
          title = "Exploratory data analysis", 
          eda_ui(id = "eda") ),
        
        tabPanel(
          title = "Pan-species analysis",
          targeted_analysis_ui(id = "targeted_analysis") )
        
        )
    )
  )
)
