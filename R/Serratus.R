# Serratus Object
#' An S4-Object definition for storing Serratus output data
#' 
#' @slot sra    A string vector of SRA identifiers
#' @slot header A data frame with header information for each file (genome, date)
#' @slot family A data frame with information about detected families
#' @slot acc    A data frame with information about detection per accession
#' @keywords Serratus, summary, object
#' @export
#
Serratus <- setClass(Class = "Serratus",
                     slots = c(sra    = "character",
                               header = "data.frame",
                               family = "data.frame",
                               acc    = "data.frame"))