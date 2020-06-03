#' Parse list of files into S4 Serratus class
#'
#' @param  sumFiles A vector Path to serratus summary file
#'
#' @return Serratus S4 class
#'
#' @export
#'
readSerratus <- function(sumFiles){
  # Read each entry in Serratus as S3 class
  # and output the Serratus S4 class

  SRA <- as.character(sapply(sumFiles, readSra))

  HEADER <- data.frame(t(sapply(sumFiles, readHeader)))

  HITS_Family <- lapply(sumFiles, readHits, family=T)
  HITS_Family <- do.call(rbind.data.frame, HITS_Family)

  HITS_ACC <- lapply(sumFiles, readHits, family=F)
  HITS_ACC <- do.call(rbind.data.frame, HITS_ACC)

  SERRATUS <- Serratus(sra    = SRA,
                       header = HEADER,
                       family = HITS_Family,
                       acc    = HITS_ACC)
  return(SERRATUS)
}
