# getSraRunInfo
#' Downloads an SRA runInfo file and parses
#' into a RunInfo S4 object
#' 
#' Implicit system dependcies
#' - aws cli
#' 
#' @param runInfo a string of the name of the sraRunInfo.csv file
#' @param s3_path a string s3 path holding sraRunInfo.csv file
#' @param local_path local path into which to download the data [sra]
#' @keywords Tantalus, S3, runInfo, sra
#' @examples
#' getRunInfo(runInfo = "viro_SraRunInfo.csv",
#'            s3_path = "s3://lovelywater/sra/",
#'            local_path = "sra")
#' 
#' @export
#' 
getSraRunInfo <- function(runInfo,
                          s3_path = 's3://lovelywater/sra/',
                          local_path = 'sra'){
  
  system(paste0( 'mkdir -p ', local_path))
  
  system_getSra <- paste0("aws s3 cp ",
                          s3_path,runInfo," ",
                          local_path, "/")
  print(system_getSra)
  
  system(system_getSra)
}
