#' Extract a family information from a file line
#'
#'
#' @param  hit string line with family accession
#' @param  sra SRA identifier
#'
#' @return data frame (with one row for one file)
#'
#' @export
#'
parseFamilies <- function(hit, sra = ''){

  #remove name
  x <- unlist(strsplit(hit, "topname="))
  topname <- x[2]
  x <- x[1]
  
  x <- unlist(strsplit(x, ";"))
  x <- paste(x[grep( "=", x )], collapse="\n")
  hit.table <- read.table(text=x, sep="=", quote="")

  # Wrangle data into R formats
  #sra
  family       <- as.character(hit.table[ hit.table[,1] == 'family' , 2])
  score        <- as.numeric(as.character(hit.table[ hit.table[,1] == 'score', 2]))
  pctid        <- as.numeric(hit.table[ hit.table[,1] == 'pctid', 2])
  aln          <- as.numeric(as.character(hit.table[ hit.table[,1] == 'aln', 2]))
  glb          <- as.numeric(as.character(hit.table[ hit.table[,1] == 'glb', 2]))
  panlen       <- as.numeric(as.character(hit.table[ hit.table[,1] == 'panlen', 2]))
  cvg          <- as.character(hit.table[ hit.table[,1] == 'cvg', 2])
  top          <- as.character(as.character(hit.table[ hit.table[,1] == 'top', 2]))
  topaln       <- as.numeric(hit.table[ hit.table[,1] == 'topaln', 2])
  toplen       <- as.numeric(hit.table[ hit.table[,1] == 'toplen', 2])
  #topname      <- as.character(hit.table[ hit.table[,1] == 'topname', 2])
  topname      <- as.character(topname)


  hit.df <-  data.frame( sra      = sra,
                         family   = family,
                         score    = score,
                         pctid    = pctid,
                         aln      = aln,
                         glb      = glb,
                         panlen   = panlen,
                         cvg      = cvg,
                         top      = top,
                         topaln   = topaln,
                         toplen   = toplen,
                         topname  = topname)


  return(hit.df)
}
