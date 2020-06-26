#' getHeatmap
#' 
#' Build a heatmap for the provided accession and SRA files
#'
#' @param  accession   Accession, for which coverage should be plotted 
#' @param  files   Files to parse 
#' @return plotly figure
#' @keywords Serratus, accession, coverage, plotly
#'
#' @import plotly
#' @export
#`

getHeatmap <- function(accession, files){
  
  newvals <- c('_'=0,'.'=0.25,'o'=0.5, 'O'=0.75)
  
  dfs <- readDFs(files, columns = c("sra", "acc", "cvg"), acc = accession)
  
  listcover <- lapply(dfs$cvg, function(x) { substring(x, seq(1, nchar(x), 1), seq(1, nchar(x), 1)) })
  
  test <- lapply(listcover, function(x){ 
    newvals <- c('_'=0,'.'=0.25,'o'=0.5, 'O'=0.75)
    return(newvals[x])
  })
  
  heatmap <- as.data.frame(test)
  heatmap <- t(heatmap)
  rownames(heatmap) <- dfs$sra
  colnames(heatmap) <- seq(1,25)
  
  fig <- plot_ly(x = seq(1,25), y = rownames(heatmap), z = heatmap, type = "heatmap",name = accession) %>% layout(title = accession)
  
  return(fig)
  
}