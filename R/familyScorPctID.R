#' Plot a scatterplot/histogram of percentage identity vs family score for a given family
#'
#'
#' @param  serratus serattus S4 object with family data frame
#' @param  family_name name of the family
#'
#' @return ggplot
#'
#' @examples
#' 
#' familyScorPctID(ZOO, "Coronaviridae")
#' 
#' @export
#'
familyScorPctID <- function(serratus, family_name){
  family_df <- serratus@family %>% filter(family %in% c(family_name))
  
  p <- ggplot(data=family_df, aes(x = score, y = pctid)) +
    geom_jitter(color="blue", alpha = 0.4) + 
    theme_bw() +
    labs(x = "Family score", y = "Percentage identity") +
    labs(title = paste(family_name, "family", sep = " "))
  s <- ggExtra::ggMarginal(p, type = "histogram")
  return(s)
}