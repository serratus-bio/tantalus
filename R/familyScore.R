#' Plot a histogram of scores for a given family
#'
#'
#' @param  family_df family data frame
#' @param  family_name name of the family
#' @param  x1 left limit on x axis
#' @param  x2 right limit on x axis
#' @param log log10 y axis or not (default F)
#'
#' @return ggplot
#'
#' @examples
#' 
#' familyScore(ZOO, "Coronaviridae")
#' 
#' @export
#'
familyScore <- function(family_df, family_name, x1=0, x2=100, log=F){
  family_df <- family_df %>% filter(family %in% c(family_name))
  
  if (log == F){
    p <- ggplot(data=family_df, aes(family_df$score)) + 
      geom_histogram(fill="blue", bins = 30) +
      theme_bw() +
      coord_cartesian(xlim=c(x1,x2)) +
      labs(x = "Family score") +
      labs(title = paste(family_name, "family", sep = " "))
  } else {
    p <- ggplot(data=family_df, aes(family_df$score)) + 
      geom_histogram(fill="blue", bins = 30) +
      theme_bw() +
      scale_y_log10() +
      coord_cartesian(xlim=c(x1,x2)) +
      labs(x = "Family score") +
      labs(title = paste(family_name, "family (log10 y axis)", sep = " "))
  }
  
  
  return(p)
}