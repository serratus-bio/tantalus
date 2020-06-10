#' Parse folder with Atys objects and retreive info about number of unique SRAs, GBs of data analyzed and sum of nucleotides
#'
#'
#' @param  folder_with_atys folder with atys objects 
#'
#' @return list with 3 values
#'
#' @examples
#' 
#' parseAtys(DATA_PATH)
#' 
#' @export
#'
parseAtys <- function(folder_with_atys){
  atys_files <- paste0( folder_with_atys,
                        system( paste0("ls ", DATA_PATH), intern = T ))
  
  test <- lapply(atys_files, function(x) {
    y <- readRDS(x)
    y <- y@SRA@runInfo[,c("Run","size_MB","spots", "spots_with_mates")]
    y <- as.data.frame(y)
    return(y)
  })
  
  test <- rbindlist(test)
  
  test <- test[!duplicated(test$Run), ]
  
  #number of unique sras:
  nsras <- nrow(test)
  
  #sums of mb used (and converted to gb)
  mbs <- sum(test$size_MB)
  gbs <- mbs / 1000
  
  #how many nucleotides were analyzed
  spots_sum <- sum(test$spots)
  spots_with_mates_sum <- sum(test$spots_with_mates)
  nucl_sum <- spots_sum + spots_with_mates_sum
  
  res_lis <- list(nsras, gbs, nucl_sum)
  names(res_lis) <- c("Num_SRAs", "GBs", "Nucl_SUM")
  
  return(res_lis)
}