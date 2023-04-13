draw_scatter_plot <- function(inData, inXaxislab, inYaxislab) {
  
  p <- ggplot(
    data = inData,
    mapping = aes(x = Length.x, y = Length.y, color = Species)) +
    geom_point() + 
    xlab(inXaxislab) +
    ylab(inYaxislab)
  
  print(p)
  
}
