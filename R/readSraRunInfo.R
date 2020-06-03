# readSraRunInfo
#' Parse a SraRunInfo csv file into a clean data.frame
#' and return a SraRunInfo S4 object
#'
#' @param  sraCSV The path to an sraRunInfo.csv file
#'
#' @return SraRunInfo S4 object
#' @keywords Serratus, SRA, SraRunInfo, parsing
#'
#' @export
#`
readSraRunInfo <- function(sraCSV){
  # Read a SraRunInfo.csv file as an S3 class
  # parse into efficient data.frame
  # return SraRunInfo S4 object
  
  SRA <- SraRunInfo( runInfo = read.csv(sraCSV, stringsAsFactors = F) )
  
  return(SRA)
}
