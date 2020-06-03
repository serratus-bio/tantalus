#' SraRunInfo
#'
#' An S4-Object definition for the SRA's "runInfo"
#' csv files. Downloaded from website.
#' Send to --> File --> runInfo
#' 
#' @slot RunInfo Data.frame of SRA "runInfo" csv file
#' @keywords Serratus, object, runInfo, SRA
#' @export
#' @rdname SraRunInfo
SraRunInfo <- setClass( Class = "SraRunInfo",
                        slots = c(runInfo = "data.frame"))

