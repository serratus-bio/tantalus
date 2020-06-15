#' getLoadedSummaryFiles
#' 
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
#' 
#' @export
#' 
getLoadedSummaryFiles <- function(sras, path_to_files=""){
  
  #not optimal
  sumWheres_all <- paste(path_to_files, system( paste0("ls ", path_to_files), intern = T), sep="/")
  
  summary_files <- paste(sras, "summary", sep=".")
  
  sumWheres <- paste(path_to_files, summary_files, sep="/")
  
  #remove files that are absent in the specified folder
  files_to_analyze <- intersect(sumWheres_all, sumWheres)
  
  serratusObj <- readSerratus( files_to_analyze )
  
  return(serratusObj)
  
}