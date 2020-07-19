#' readDfSQL
#' 
#' Read SQL data into data frame
#'
#' @param  dbs     Database object (SQL)
#' @param  table   Table in the database
#' @param  columns character vector of columns to return. NULL returns all [Default] 
#' @param  family  character, if specified return only matching "Family"
#' @param  acc     character, if specified return only matching virus accesion "Top"
#' @param  sras    character, return only specified accessions
#' @param  dataframe    boolean, if T, convert the output to dataframe
#' @return data frame
#' @keywords Serratus, summary, parsing
#'
#' @export
#`
readDfSQL <- function(dbs, table, columns = NULL, family = NULL, acc = NULL, 
                      sras = NULL, dataframe=F, score = NULL, pctid = NULL){
  db_table <- tbl(dbs, table)
  
  if (!is.null(sras)){
    db_table <- db_table %>% filter(Sra %in% sras)
  }
  
  if (!is.null(family)){
    if ( sum( grepl('Acc', colnames(db_table))) > 0 ){
      # In accession_df family == 'Fam'
      db_table <- db_table %>% filter(Fam %in% family)
    } else {
      # In accession_df family == 'Family'
      db_table <- db_table %>% filter(Family %in% family)
    }
  }
  
  if (!is.null(columns)){
    db_table <- db_table %>% select(columns)
  }
  
  if (!is.null(acc)){
    if ( sum( grepl('Acc', colnames(db_table))) > 0 ){
      # In accession_df accessions == 'Acc'
      db_table <- db_table %>% filter(Acc %in% acc)
    } else {
      # In family_df accession == `Top`
      db_table <- db_table %>% filter(Top %in% acc)
    }
  }
  
  if (!is.null(score)){
    db_table <- db_table %>% filter(Score > score)
  }
  
  if (!is.null(pctid)){
    db_table <- db_table %>% filter(Pctid > pctid)
  }
  
  if (dataframe == T){
    db_table <- db_table %>% as.data.frame()
  }
  
  return(db_table)
}
