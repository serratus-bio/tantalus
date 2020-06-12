#' getLoadedSummaryFiles
#' Parses the specified list of SRA accessions (which are supposed to be present in the specified folder)
#' into a Serratus S4 object
#' 
#' Implicit system dependcies
#' - aws cli
#' 
#' @param sras a string vector of the SRAs 
#' @param path_to_files a local folder with the SRA summary files
#' 
#' @return Serratus S4 class
#' 
#' @examples
#' sras <- c("SRR9701190", "SRR9705127", "SRR975462", "SRR9843091", "SRR9843092")
#' serr <- getSummaryFiles(sras, 's3://serratus-public/out/200528_viro/summary/', "summary_files")
#' 
#' @export
#' 
getLoadedSummaryFiles <- function(sras, path_to_files=""){
  
  summary_files <- paste(sras, "summary", sep=".")
  
  sumWheres <- paste(path_to_files, summary_files, sep="/")
  
  serratusObj <- readSerratus( sumWheres )
  
  return(serratusObj)
  
}