draw_blank_plot_with_a_comment <- function(inText) {
  
  p <- ggplot(
    data = data.frame()) +
    geom_text(
      aes(x = 1, y = 1, label = inText),
      hjust = 0.5, vjust = 0.5,
      size = 5,
      color = "#C0A0A0",
      inherit.aes = FALSE) +   
    theme_bw() +
    theme(
      axis.ticks = element_blank(),
      axis.text = element_blank(),
      axis.title =  element_blank(),
      panel.grid = element_blank(),
      strip.background = element_blank(),
      panel.border = element_rect(colour = "black", fill = NA),
      strip.text = element_text(colour = "black", face = "bold", size = 14))
  
  print(p)
  
} 
