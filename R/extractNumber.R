#' extract numbers from the heading
#'
#' For summary headers, extract value
#' description=value;
#'
#' @param inputString string with the value
#'
#' @return value
#'
#'
#' @export
extractNumber <- function(inputString){
  inputString <- sub('^.*=', '', inputString)
  inputString <- sub(';', '',    inputString)
  inputString <- as.numeric(inputString)
  return(inputString)
}
