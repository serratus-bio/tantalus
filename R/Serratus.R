#' An S4 class to store parsed summary files.
#'
#' @slot sra    A vector of SRA identifiers (one identifier per file)
#' @slot header A data frame with header information for each file (genome, date)
#' @slot family A data frame with information about detected families
#' @slot acc    A data frame with information about detected organisms
Serratus <- setClass(Class = "Serratus",
                     slots = c(sra    = "character",
                               header = "data.frame",
                               family = "data.frame",
                               acc    = "data.frame"))
