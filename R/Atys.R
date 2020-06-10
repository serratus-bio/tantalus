#' SraRunInfo
#'
#' An S4-Object (summary object) that combines 3 class types
#' for the same dataset: Serratus class, SraRunInfo class, and Genome class
#' 
#' @slot Serratus S4 Serratus object
#' @slot SRA S4 SraRunInfo object
#' @slot GENOME S4 Genome object (character place holder for now)
#' @keywords Serratus, SraRunInfo, Genome, object
#' @export
#' @rdname Atys
Atys <- setClass(Class = "Atys",
                 slots = c(Serratus = "Serratus",
                           SRA = "SraRunInfo",
                           GENOME = "character"))