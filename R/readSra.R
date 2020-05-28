#' read SRA identifiers from provided files
#'
#' Creates a vector of SRA identifiers
#'
#' @param  sumFile the name of the summary file "SRA_ID.summary"
#'
#' @return SRA identifier
#'
#' @export
readSra <- function(sumFile){
  sra  <-  sub('^.*/', '', sumFile)
  sra  <-  sub('.summary', '', sra)

  return(sra)
}
