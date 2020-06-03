#' Extract an organism information from a file line
#'
#'
#' @param  hit string line with organism accession
#' @param  sra SRA identifier
#'
#' @return data frame (with one row for one file)
#'
#' @export
#'
parseHits <- function(hit, sra = ''){

  #remove name
  x <- unlist(strsplit(hit, "name="))
  name <- x[2]
  x <- x[1]
  
  x <- unlist(strsplit(x, ";"))
  x <- paste(x[grep( "=", x )], collapse="\n")
  hit.table <- read.table(text=x, sep="=", quote="")

  acc          <- as.character(hit.table[ hit.table[,1] == 'acc' , 2])
  pctid        <- as.numeric(as.character(hit.table[ hit.table[,1] == 'pctid', 2]))
  aln          <- as.numeric(hit.table[ hit.table[,1] == 'aln', 2])
  glb          <- as.numeric(as.character(hit.table[ hit.table[,1] == 'glb', 2]))
  len          <- as.numeric(as.character(hit.table[ hit.table[,1] == 'len', 2]))[1] #duplicated for sm reason
  cvgpct       <- as.numeric(as.character(hit.table[ hit.table[,1] == 'cvgpct', 2]))
  depth        <- as.numeric(hit.table[ hit.table[,1] == 'depth', 2])
  cvg          <- as.character(as.character(hit.table[ hit.table[,1] == 'cvg', 2]))
  fam          <- as.character(hit.table[ hit.table[,1] == 'fam', 2])
  #name         <- as.character(hit.table[ hit.table[,1] == 'name', 2])
  name         <- as.character(name)


  hit.df <-  data.frame( sra      = sra,
                         acc      = acc,
                         pctid    = pctid,
                         aln      = aln,
                         glb      = glb,
                         len      = len,
                         cvgpct   = cvgpct,
                         depth    = depth,
                         cvg      = cvg,
                         fam      = fam,
                         name     = name)

  return(hit.df)
}
