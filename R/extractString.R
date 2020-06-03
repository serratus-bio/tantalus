#' extract strings from the heading
#'
#' For summary headers, extract string value
#' description=string;
#'
#' @param  inputString string with the value
#'
#' @return string value
#'
#'
#' @export
extracSrting <- function(inputString){
  inputString <- sub('^.*=', '', inputString)
  inputString <- sub(';', '',    inputString)
  inputString <- as.character(inputString)
  return(inputString)
}
