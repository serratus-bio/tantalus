# parseSummaryFiles
#' 
#' Parse specified summary files into compressed fst data frames
#' which contain either family or accession info.
#'
#' @param  files The path to summary files
#' @param  outputFolder The output folder
#' @param  parseFamily  True if you want to extract family information, False - if accessions
#' @param  compressLevel  Level of df compression (fst parameter), default is 100
#'
#' @return None
#' @keywords Serratus, summary, parsing
#'
#' @export
#`
parseSummaryFiles <- function(files, outputFolder="parsed_df/", parseFamily=T, compressLevel=100){
  HITS_Family <- lapply(files, function(x){
    
    sra  <-  sub('^.*/', '', x)
    sra  <-  sub('.summary', '', sra)
    
    res <- readHits(x, family = parseFamily)
    
    system(paste('mkdir -p ', outputFolder, sep=""))
    
    if (nrow(res) != 0){
      write.fst(res, paste(outputFolder, sra, ".fst", sep=""), compress = compressLevel)
    }
  })
}