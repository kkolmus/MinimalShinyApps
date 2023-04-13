input_selector_ui <- function(id, inIconName, inInputId, inLabel, inComingInput) {
  ns <- NS(id)
  
  fluidRow(
    column(
      width = 12,
      icon(
        name = inIconName,
        class = "fa-1x",
        lib = "font-awesome"),
      tags$style(".selectize-input input {font-size: 13px;} .selectize-dropdown {font-size: 13px;}"),
      selectizeInput(
        inputId = inInputId,
        label   = inLabel,
        choices = inComingInput,
        multiple = FALSE
      ) 
    )
  )
  
}
