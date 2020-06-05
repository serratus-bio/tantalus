#' Plot a histogram of scores for a given family
#'
#'
#' @param  serratus serattus S4 object with family data frame
#' @param  family_name name of the family
#' @param  x1 left limit on x axis
#' @param  x2 right limit on x axis
#'
#' @return ggplot
#'
#' @examples
#' 
#' familyScore(ZOO, "Coronaviridae")
#' 
#' @export
#'
familyScore <- function(serratus, family_name, x1=0, x2=100){
  family_df <- serratus@family %>% filter(family %in% c(family_name))
  
  p <- ggplot(data=family_df, aes(family_df$score)) + 
    geom_histogram(fill="blue", bins = 30) +
    theme_bw() +
    coord_cartesian(xlim=c(x1,x2)) +
    labs(x = "Family score") +
    labs(title = paste(family_name, "family", sep = " "))
  
  return(p)
}