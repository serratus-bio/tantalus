# getSummary
#' Downloads an S3 directory of Serratus .summary files
#' to local filesystem.
#' There is an implicit `aws cli` dependency here
#' Your system should have `aws s3` properly configured for this function
#' to work.
#' 
#' @param s3_path a string s3 path holding .summary files
#' @param local_path local path into which to download the data
#' @keywords Tantalus, S3, summary
#' @examples
#' getSummary( s3_path = 's3://lovelywater/summary/',
#'             local_path = '200528_viro')
#' @export
#' 
# s3_path    <- 's3://lovelywater/summary/'
# local_path <- '200528_viro'
#
getSummary <- function( s3_path, local_path ){
  
  # TODO: Test that system `aws s3 cp` works
  #       by downloading the token file.
  #       s3://serratus-public/var/aws-test-token.jpg
  # or
  #       Fallback to wget/curl to retrieve files
  
  # TODO: Add test to ensure that the s3_path ends in
  #       <s3_path>/summary/ , else append summary
  #       to avoid people downloading the entire
  #       directory which includes .bam files
 
  systemCMD <- paste0("aws s3 sync ",
                      s3_path,
                      '/summary/ ',
                      local_path,"/")
  
  # TODO: add warning/message suppression?s
  system( systemCMD )
}
