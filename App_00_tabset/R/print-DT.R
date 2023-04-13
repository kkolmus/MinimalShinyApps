print_DT <- function(inDataFrame) {
  inDataFrame %>%
    DT::datatable(rownames = FALSE)
}
