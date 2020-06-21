# getBam
#' Downloads an SRA accession from an experiment S3 directory
#' 1) download bam file
#' 2) sort bam file (samtools)
#' 3) index bam file (samtools)
#' 
#' Implicit system dependcies
#' - samtools
#' - aws cli
#' 
#' @param sra SRA accession to download
#' @param s3_path a string s3 path holding .summary files
#' @param local_path local path into which to download the data [bam]
#' @keywords Tantalus, S3, bam, samtools
#' @examples
#' 
#' getBam(sra = 'SRR5447135', s3_path = 's3://lovelywater/bam/')
#' 
#' @export
#' 
getBAM <- function(sra,
                   s3_path = 's3://lovelywater/',
                   local_path = 'bam'){
  
  system(paste0( 'mkdir -p ', local_path))
  
  system_getBam <- paste0("aws s3 cp ",
                          s3_path,"/bam/",sra,'.bam',
                          ' ', local_path, "/")
  
  system(system_getBam)
  
  # Sort and index the downloaded bam file
  system(paste0('samtools sort bam/', sra, '.bam > bam/tmp.bam')) 
  system(paste0('mv bam/tmp.bam bam/', sra,'.bam'))
  system(paste0('samtools index bam/', sra,'.bam'))
  
}
