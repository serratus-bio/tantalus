#' Extract all family or organism information from the provided file
#'
#'
#' @param  sumFile Serratus summary file
#' @param  family  If True - extract family information; False - extract organism information (default)
#'
#' @return data frame with extracted information
#'
#' @export
#'
readHits <- function(sumFile, family=FALSE){
  # Import summary table as a flat file
  importSummary <- read.table( file = sumFile, sep = ">",
                               header = F, as.is = T)

  sra  <-  sub('^.*/', '', sumFile)
  sra  <-  sub('.summary', '', sra)

  if (family == TRUE){
    hits <- importSummary[ grep( "^family=", importSummary[,1] ), ]
    hits <- lapply(hits, parseFamilies, sra = sra)
    hits <- do.call(rbind.data.frame, hits)
  } else {
    hits <- importSummary[ grep( "^acc=", importSummary[,1] ), ]
    hits <- lapply(hits, parseHits, sra = sra)
    hits <- do.call(rbind.data.frame, hits)
  }

  return(hits)
}
