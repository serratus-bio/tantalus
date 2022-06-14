#' readDfSQL
#' 
#' Read SQL data into data frame
#'
#' @param  dbs     Database object (SQL)
#' @param  table   Table in the database
#' @param  columns character vector of columns to return. NULL returns all [Default] 
#' @param  family  character, if specified return only matching "family_name"
#' @param  acc     character, if specified return only matching virus accession "top_genbank_id"
#' @param  sras    character, return only specified accessions
#' @param  sraruns character, return only specified accessions, used in "srarun" table
#' @param  score    character, return only score greater than threshold
#' @param  pctid    character, return only percent_identity greater than threshold
#' @param  dataframe    boolean, if T, convert the output to dataframe
#' @return data frame
#' @keywords Serratus, summary, parsing
#'
#' @export
#`
readDfSQL <- function(dbs, table, columns = NULL, family = NULL, acc = NULL, 
                      sras = NULL, dataframe=F, score = NULL, pctid = NULL){
  # Connect to Table
  db_table <- tbl(dbs, table)
  
  # In SQL table, return only "run_id" column when matching "sras" input list
  if (!is.null(sras)){
    if (table == "srarun"){
      # In SQL table, return only "run" column when matching "sraruns" input list
      # This is the standard name in that table from NCBI
      db_table <- db_table %>% filter(run %in% sras)
    } else {
      # Serratus tables use "run_id" as accession identifier
      db_table <- db_table %>% filter(run_id %in% sras)
    }
  }
  
  # In SQL table, return only "family_name" when matching "family" input
  if (!is.null(family)){
    if ( sum( grepl('family_name', colnames(db_table))) > 0 ){
      # In accession_df family == 'Fam'
      db_table <- db_table %>% filter(family_name %in% family)
    } else {
      # In accession_df family == 'Family'
      db_table <- db_table %>% filter(family_name %in% family)
    }
  }
  
  # In SQL table, select subset of columns
  if (!is.null(columns)){
    db_table <- db_table %>% select(columns)
  }
  
  # In SQL table, return only matches for an accession
  if (!is.null(acc)){
    if ( sum( grepl('top_genbank_id', colnames(db_table))) > 0 ){
      # In accession_df accessions == 'Acc'
      db_table <- db_table %>% filter(top_genbank_id %in% acc)
    } else if ( sum( grepl('Top', colnames(db_table))) > 0 ){
      # In family_df accession == `Top`
      db_table <- db_table %>% filter(Top %in% acc)
    } else {
      print("No matching acc found.")
    }
  }
  
  score.in <- score
  if (!is.null(score)){
    db_table <- db_table %>% filter(score >= score.in)
  }
  
  if (!is.null(pctid)){
    db_table <- db_table %>% filter(percent_identity >= pctid)
  }
  
  if (dataframe == T){
    db_table <- db_table %>% as.data.frame()
  }
  
  return(db_table)
}
