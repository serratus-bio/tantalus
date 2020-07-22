# getReference
#'
#' Downlaods a Serratus Reference Sequence
#' and associated meta-data
#' * Fasta File
#' * Fasta Index
#' * Sumzer Index
#' * Masked regions bed file
#' * taxonomy file (Not Implemented)
#' 
#' Implicit system dependcies
#' - aws cli
#' - gzip
#' 
#' @param refName a string of the reference sequence base name
#' @param s3_path a string s3 path to the seq/ folder with references
#' @param local_path local path into which to download the data [seq]
#' @keywords Tantalus, S3, reference, genome, pan-genome, fasta, meta-data
#' @examples
#' 
#' getReference(refName = "cov3ma",
#'              s3_path = "s3://serratus-public/seq/",
#'              local_path = "seq")
#' 
#' @export
#'
#refName <- "cov3ma"
#s3_path <- 's3://lovelywater/seq/'
#local_path <- 'seq'
getReference <- function(refName = "cov3ma",
                         s3_path = 's3://lovelywater/seq/',
                         local_path = 'seq'){
  # TODO: Add a file-exists test to each of these commands
  #       so as not to download data which is already availble
  #       locally, unless 'force = T' is set. (add force parameter too)
  
  # Create the local_path directory
  system(paste0( 'mkdir -p ', local_path))
  # Create the refName folder in local_path
  system(paste0( 'mkdir -p ', local_path,"/",refName))
  
  # Download Fasta File
  system_getFa  <- paste0("aws s3 cp ",
                          s3_path, refName, "/",refName, ".fa ",
                          local_path, "/", refName, "/")
  
  print("Downloading Fasta File")
  print(system_getFa)
  system(system_getFa)
  
  # Download Fasta Index File
  system_getFai  <- paste0("aws s3 cp ",
                          s3_path, refName, "/",refName, ".fa.fai ",
                          local_path, "/", refName, "/")
  
  print("Downloading Fasta Index File")
  print(system_getFai)
  system(system_getFai)
  
  # Download Sumzer File
  system_getSz  <- paste0("aws s3 cp ",
                          s3_path, refName, "/",refName, ".sumzer.tsv ",
                          local_path, "/", refName, "/")
  
  print("Downloading Summary Index (sumzer) File")
  print(system_getSz)
  system(system_getSz)
  
  # Download Sumzer File
  system_getSz  <- paste0("aws s3 cp ",
                          s3_path, refName, "/",refName, ".sumzer.tsv ",
                          local_path, "/", refName, "/")
  
  print("Downloading Summary Index (sumzer) File")
  print(system_getSz)
  system(system_getSz)
  
  
  # Download masking bed file and decompress
  system_getMk  <- paste0("aws s3 cp ",
                          s3_path, refName, "/",refName, ".mask.bed.gz ",
                          local_path, "/", refName, "/")
  
  print("Downloading Masking bed File")
  print(system_getMk)
  system(system_getMk)
  system(paste0("gzip -d ", local_path, "/", refName, "/", refName, ".mask.bed.gz") )
  
  # TODO: implement automated creation of IGV XML session file
  #       as the example exists in R/seqReference_igv_template.xml
}
