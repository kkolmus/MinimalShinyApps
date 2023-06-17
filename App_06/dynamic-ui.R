library(shiny)
library(dplyr)
library(DT)

input_dataset <- c("SNV", "CNV", "EXP")

input_identifier <- c("Gene1", "Gene2", "Gene3", "Gene4", "Gene5")

# DYNAMIC UI MODULE ----

## MODULE UI ----
biomarkerUI <- function(id, number) {
  
  ns <- NS(id)
  
  tagList(
    div(id = id,
        fluidRow(
          column(
            width = 3,
            selectInput(
              inputId = ns("dataset"),
              label = paste0("Datatype ", number),
              choices = c("Choose ..." = "", input_dataset) ) ),
          column(
            width = 3,
            selectInput(
              inputId = ns("identifier"),
              label = paste0("Identifier ", number),
              choices = c("Choose ..." = "", input_identifier) ) ),
          column(
            width = 3,
            actionButton(
              inputId = ns("rmv"),
              label = "Remove biomarker",
              icon = icon(
                name = "trash",
                class = "fa-1x",
                lib = "font-awesome") ) )
          )
        )
    )
}

# MODULE SERVER ----

biomarkerServer <- function(input, output, session, bm_id) {
  
  reactive( {
    
    req(input$dataset, input$identifier)
    
    Data <- data.frame(
      "bm_id" = bm_id,
      "dataset" = input$dataset,
      "gene" = input$identifier,
      stringsAsFactors = FALSE)
    
    return(Data)
    
  } )
}

# Shiny ----

## UI ----

ui <- fluidPage(
  
  biomarkerUI(id = "var1", number = 1),
  
  p(""),
  
  actionButton(
    inputId = "insertBtn", 
    label = "New biomarker", 
    icon = icon(
      name = "plus",
      class = "fa-1x",
      lib = "font-awesome")),
  
  tableOutput(
    outputId = "table")
  
)

## SERVER ----

server <- function(input, output, session) {
  
  add.dataset <- reactiveValues()
  
  add.dataset$Data <- 
    data.frame(
      "bm_id" = numeric(0),
      "dataset" = character(0),
      "gene" = character(0),
      stringsAsFactors = FALSE)
  
  var1 <- callModule(
    module = biomarkerServer, 
    id = paste0("var", 1),
    bm_id = 1)
  
  observe(
    x = add.dataset$Data[1, ] <- var1() )
  
  observeEvent(
    eventExpr = input$insertBtn, 
    handlerExpr = {
      btn <- sum(input$insertBtn, 1)
      
      insertUI(
        selector = "p",
        where = "beforeEnd",
        ui = tagList(
          biomarkerUI(
            id = paste0("var", btn), 
            number = btn) ) )
      
      new_bm_choice <- callModule(
        module = biomarkerServer, 
        id = paste0("var", btn), 
        bm_id = btn)
      
      observeEvent(
        eventExpr = new_bm_choice(), 
        handlerExpr = {
          add.dataset$Data[btn, ] <- new_bm_choice() } )
      
      observeEvent(
        eventExpr = input[[paste0("var", btn,"-rmv")]], 
        handlerExpr = {
          removeUI(
            selector = paste0("#var", btn))
          
      temp <- btn
      
      add.dataset$Data <- add.dataset$Data %>%
        dplyr::filter(! bm_id %in% temp)
      
    })
    
    
  })
  
  output$table <- renderTable({
    
    add.dataset$Data %>% 
      na.omit()
    
  })
  
}

shinyApp(ui, server)