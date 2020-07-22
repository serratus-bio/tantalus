#' seqReference
#'
#' An S4-Object definition for the Pan-Genome / Query Reference
#' 
#' Contains:
#'  - Fasta index of genome (.fa.fai)
#'  - Summarizer Meta-data file (.sumzer.tsv)
#'  - Serratax taxonomy information (.serratax) [not implemented]
#'
#' @slot rname  String of reference version name
#' @slot fai    Data.frame for a fasta index file
#' @slot sumzer Data.frame of the summarizer meta-data
#' @slot tax    Data.frame of the serratax output taxonomy information
#' 
#' @keywords Serratus, object, reference, genome, pan-genome, summary, meta-data
#' @rdname seqReference
#' @export
  seqReference <- setClass( Class = "seqReference",
                            slots = c(rname  = 'vector',
                                      fai    = 'data.frame',
                                      sumzer = 'data.frame',
                                      tax    = 'data.frame'))
