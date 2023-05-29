library(tidyverse)
library(shiny)
library(shinydashboard)

X <- iris
species <- X$Species %>% unique() %>% as.character()
features <- colnames(X) %>% .[1:4]

header <- dashboardHeader(
  title = "Demo App",
  
  tags$li(
    class = "dropdown",
    style = "padding: 5px;",
    actionButton(
      inputId = "question",
      label = "Help",
      icon = icon(
        name = "question",
        class = "fa-1x",
        lib = "font-awesome") ) ),
  
  tags$li(
    class = "dropdown",
    style = "padding: 5px;",
    actionButton(
      inputId = "contact",
      label = "Contact",
      icon = icon(
        name = "envelope",
        class = "fa-1x",
        lib = "font-awesome") ) )
  
)

sidebar <- dashboardSidebar(
  collapsed = FALSE,
  sidebarMenu(
    # Setting id makes input$tabs give the tabName of currently-selected tab
    id = "tabs",
    menuItem(
      text = "Iris dataset & Species", 
      tabName = "dashboard", 
      icon = icon("database"),
      
      tags$li(
        class = "dropdown",
        style = "padding: 5px;",
        selectInput(
          inputId = "dataset",
          label = "Dataset: (pick one)",
          choices = c("...", "Iris"),
          selected = NULL),
        selectInput(
          inputId = "species",
          label = "Species: (pick one)",
          choices = c("...", species),
          selected = NULL),
        numericInput(
          inputId = "column_count",
          label = "Features: (select 1:4)",
          value = 1,
          min = 1,
          max = 4),
        actionButton(
          inputId = "apply",
          label = "Apply",
          icon = icon(
            name = "check",
            class = "fa-1x",
            lib = "font-awesome") )
        
      )
    ),
    menuItem(
      text = "Analysis", 
      icon = icon("bar-chart-o"),
      menuSubItem(
        "Feature analysis", 
        tabName = "subitem1"),
      menuSubItem(
        "Integrated analysis", 
        tabName = "subitem2")
    )
  )
)

select_feature_box_ui <- function(inFeatures, inNb) {
  
  div(
    title = paste0("Feature ", inNb),
    selectInput(
      inputId = paste0("feature", inNb),
      label = paste("Feature ", inNb, ": (pick one)"),
      choices = c("...", inFeatures),
      selected = NULL) )
  
}

visualize_feature_box_ui <- function(id) {

  div(
    plotOutput(id, height = 250)
  )

}


confirm_step_1_ui <- function() {
  
  div( 
    style="display:inline-block;margin-left: 46%;padding-bottom: 10px;",
    actionButton(
      inputId = "confirm",
      label = "Confirm",
      icon = icon(
        name = "check",
        class = "fa-1x",
        lib = "font-awesome") ) )
  
}


body <- dashboardBody(
  shinyjs::useShinyjs(),
  shinyjs::hidden(div(
    id  = "analysis_steps",
    tabItems(
      tabItem(
        tabName = "subitem1",
        h1("Feature analysis"),
        fluidRow(
          column(
            width = 3, 
            title = "Feature 1", 
            class = "target-column",
            select_feature_box_ui(inFeatures = features, inNb = 1) ),
          conditionalPanel(
            condition = "input.column_count >= 2",
            column(
              width = 3, 
              title = "Feature 2", 
              class = "target-column",
              select_feature_box_ui(inFeatures = features, inNb = 2) ) ),
          conditionalPanel(
            condition = "input.column_count >= 3",
            column(
              width = 3, 
              title = "Feature 3", 
              class = "target-column", 
              select_feature_box_ui(inFeatures = features, inNb = 3) ) ),
          conditionalPanel(
            condition = "input.column_count >= 4",
            column(
              width = 3, 
              title = "Feature 4", 
              class = "target-column",
              select_feature_box_ui(inFeatures = features, inNb = 4) ) ) ),
        fluidRow( confirm_step_1_ui() ),
      fluidRow(
        column(
          width = 3,
          class = "target-column",
          visualize_feature_box_ui(id = "plot1") ),
        conditionalPanel(
          condition = "input.column_count >= 2",
          column(
            width = 3,
            class = "target-column",
            visualize_feature_box_ui(id = "plot2") ) ),
        conditionalPanel(
          condition = "input.column_count >= 3",
          column(
            width = 3,
            class = "target-column",
            visualize_feature_box_ui(id = "plot3") ) ),
        conditionalPanel(
          condition = "input.column_count >= 4",
          column(
            width = 3,
            class = "target-column",
            visualize_feature_box_ui(id = "plot4") ) ) )
      ),
      tabItem(
        tabName = "subitem2",
        h1("Integrated analysis")) 
    )
  )),
  tags$script(
    type = "text/javascript",
    "
            const btn = document.querySelector('button[type=submit]');
            const input = document.getElementById('column_count');
            btn.addEventListener('click', function(event) {
                // calculate new width
                w = 12 / input.options[input.selectedIndex].value;
                console.log('new width', w);

                // update classes
                const columns = document.querySelectorAll('.target-column');
                columns.forEach(function(column) {
                    column.className = 'col-sm-' + w + ' target-column';
                });
            })
            "
  )
)

ui <- dashboardPage(
  header,
  sidebar,
  body,
  title = "Demo App",
  skin = "purple"
)

server <- function(input, output, session) {
  
  dataset <- reactive({ X })
  
  species.selected <- eventReactive(input$apply, {
    input$species
  })
  
  feature1.selected <- eventReactive(input$confirm, {
    input$feature1
  })
  
  feature2.selected <- eventReactive(input$confirm, {
    input$feature2
  })
  
  feature3.selected <- eventReactive(input$confirm, {
    input$feature3
  })
  
  feature4.selected <- eventReactive(input$confirm, {
    input$feature4
  })
  
  observe(print(species.selected()))
  observe(print(feature1.selected()))
  observe(print(feature2.selected()))
  observe(print(feature3.selected()))
  observe(print(feature4.selected()))
  
  data <- reactive( {
    req(species.selected())
    
    dataset() %>%
      dplyr::filter(Species == species.selected())
  } )
  
  
  output$plot1 <- renderPlot({
    req(feature1.selected())

    data_selected <- X %>%
      dplyr::pull(feature1.selected())
    lable <- gsub("\\.", " ", feature1.selected())
    hist(
      data_selected,
      main = paste0("Histogram of ", lable),
      xlab = lable)
  })
  
  output$plot2 <- renderPlot({
    req(feature1.selected())
    
    data_selected <- X %>%
      dplyr::pull(feature2.selected())
    lable <- gsub("\\.", " ", feature2.selected())
    hist(
      data_selected,
      main = paste0("Histogram of ", lable),
      xlab = lable)
  })
  
  output$plot3 <- renderPlot({
    req(feature1.selected())
    
    data_selected <- X %>%
      dplyr::pull(feature3.selected())
    lable <- gsub("\\.", " ", feature3.selected())
    hist(
      data_selected,
      main = paste0("Histogram of ", lable),
      xlab = lable)
  })
  
  output$plot4 <- renderPlot({
    req(feature1.selected())
    
    data_selected <- X %>%
      dplyr::pull(feature4.selected())
    lable <- gsub("\\.", " ", feature4.selected())
    hist(
      data_selected,
      main = paste0("Histogram of ", lable),
      xlab = lable)
  })
  
  observeEvent(input$question, {
    showModal(modalDialog(
      title = "Help",
      "test",
      size = "l",
      easyClose = TRUE
    ))
  })
  
  observeEvent(input$contact, {
    showModal(modalDialog(
      title = "Contact us",
      "test",
      size = "l",
      easyClose = TRUE
    ))
  })
  
  observeEvent(input$apply, {
    shinyjs::toggle(
      id = "analysis_steps",
      anim = TRUE,
      animType = "slide")
  })
  
}

shinyApp(ui, server)
