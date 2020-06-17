#' readDFs
#' 
#' Read fst serialized objects into data frame
#'
#' @param  files Files to parse into a single df
#' @param  all   If you want to parse all columns (True by default)
#' @param  columns if all is False, you need to provide a vector of column names you want to extract
#'
#' @return data frame
#' @keywords Serratus, summary, parsing
#'
#' @export
#`
readDFs <- function(files, all=T, columns = c()){
  if (all==T){
    hits <- lapply(files, function(x){
      df_subset <- read.fst(x)
      return(df_subset)
    })
    
    suppressWarnings(y <- dplyr::bind_rows(hits))
    
  } else {
    hits <- lapply(files, function(x){
      df_subset <- read.fst(x, columns)
      return(df_subset)
    })
    
    suppressWarnings(y <- dplyr::bind_rows(hits))
  }
  
  return(y)
  
}