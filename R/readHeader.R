#' Extract header information
#'
#' @param  sumFile summary file
#'
#' @return header data frame (with one row for one file)
#'
#' @export
readHeader <- function(sumFile){
  # Import summary table as a flat file
  #and read the first line
  importSummary <- readLines(sumFile)
  #importSummary <- read.table( file = sumFile, sep = ">",
  #                             header = F, as.is = T, quote = "")[1,]

  sra  <-  sub('^.*/', '', sumFile)
  sra  <-  sub('.summary', '', sra)
  sra  <-  as.character(sra)

  header_string <- unlist(strsplit(importSummary, ","))

  genome <- extracSrting(header_string[ grep( "genome=", header_string) ])
  date <- extracSrting(header_string[ grep( "date=", header_string) ])

  header <- data.frame( sra = sra,
                        genome = genome,
                        date = date,
                        stringsAsFactors = F)
  return(header)
}
