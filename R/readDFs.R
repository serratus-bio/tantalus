#' readDFs
#' 
#' Read fst serialized objects into data frame
#'
#' @param  files   Files to parse into a single df
#' @param  all     DEPRECATED: If you want to parse all columns (True by default)
#' @param  columns character vector of columns to return. NULL returns all [Default] 
#' @param  family  character, if specified return only matching "family"
#' @param  acc     character, if specified return only matching virus accesion "top"
#' @return data frame
#' @keywords Serratus, summary, parsing
#'
#' @export
#`

# Serratus Summary read.fst function
readFST <- function(file, columns = NULL, family = NULL, acc = NULL){

  if (is.null(columns)){
    df_subset <- read.fst(path = file)
  } else {
    df_subset <- read.fst(path = file, columns)
  }
  
  if (!is.null(family)){
    df_subset <- df_subset[ df_subset$family == family, ]
  }

  
  if (!is.null(acc)){
    if ( sum( grepl('acc', colnames(df_subset))) > 0 ){
      # In accession_df accessions == 'acc'
      df_subset <- df_subset[ df_subset$acc    == acc, ]
    } else {
      # In family_df accession == `top`
      df_subset <- df_subset[ df_subset$top    == acc, ]
    }
  }
  
  return(df_subset)
  
}

# lapply Wrapper for readFST
readDFs <- function(files, all=T, columns = NULL, family = NULL, acc = NULL){

  hits <- lapply( files, readFST, columns = columns, family = family, acc = acc)
  suppressWarnings(y <- dplyr::bind_rows(hits))
  return(y)
  
}
