server <- function(input, output, session) {

  visualization <-
    iris %>%
    tidyr::pivot_longer(
      ! Species,
      names_to = "Feature",
      values_to = "Length") %>%
    dplyr::mutate(Species = factor(Species)) %>%
    dplyr::filter(
      Feature == "Petal.Length")
    
  
  output$plot <- renderPlot(
    
    expr = {
      
      ggplot(
        data = visualization,
        mapping = aes(
          x = Species, 
          y = Length,
          fill = Feature)) +
        geom_jitter() +
        geom_boxplot() 
      
    }
    
  )
  
  output$tooltip <- renderUI({
    
    req(visualization)
    req(input$hover_plot, nrow(visualization) > 0)
    
    levels_flowers <- levels(visualization$Species)
    name_flower <- levels_flowers[round(input$hover_plot$x)]
    req(length(name_flower) > 0)
    
    stat_input <- 
      visualization %>%
      dplyr::filter(
        Species == name_flower) %>%
      dplyr::select(
        Length) %>%
      summary() %>%
      as.data.frame() %>%
      tidyr::separate(
        col = "Freq", 
        into = c("Statistic", "Value"), 
        sep = ":")
    if (length(stat_input) == 0) return(NULL)
    
    wellPanel(
      p(HTML(glue::glue(
        "
        <b> Species: </b> {name_flower} <br/>
        <b> Min: </b> {stat_input[1,4]} <br/>
        <b> Q1: </b> {stat_input[2,4]} <br/>
        <b> Median: </b> {stat_input[3,4]} <br/>
        <b> Mean: </b> {stat_input[4,4]} <br/>
        <b> Q3: </b> {stat_input[5,4]} <br/>
        <b> Max: </b> {stat_input[6,4]} <br/>
        "
      )))
    )
    
  })
  
}
