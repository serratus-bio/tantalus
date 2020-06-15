#' getSummaryFiles
#' Downloads a specified list of summary files and parses them
#' into a Serratus S4 object
#' 
#' Implicit system dependcies
#' - aws cli
#' 
#' @param sras a string vector of the SRAs to download
#' @param s3_path a string s3 path to summary files
#' @param local_path local path into which to download the data 
#' @keywords Tantalus, S4, Serratus, sra
#' 
#' @return Serratus S4 class
#' 
#' @examples
#' sras <- c("SRR9701190", "SRR9705127", "SRR975462", "SRR9843091", "SRR9843092")
#' serr <- getSummaryFiles(sras, 's3://lovelywater/summary/', "summary_files")
#' 
#' @export
#' 
getSummaryFiles <- function(sras,
                            s3_path = 's3://lovelywater/summary/',
                            local_path = 'summary_files'){
  
  summary_files <- paste(sras, "summary", sep=".")
  
  system(paste0( 'mkdir -p ', local_path))
  
  test <- sapply(summary_files, function(x){
    system_getSummary <- paste0("aws s3 cp ",
                                s3_path, x, " ",
                                local_path, "/")
    print(system_getSummary)
    system(system_getSummary)
  })
  
  sumWheres <- paste( local_path,
                      system( paste0("ls ", local_path), intern = T ), sep="/")
  
  serratusObj <- readSerratus( sumWheres )
  
  return(serratusObj)
  
}