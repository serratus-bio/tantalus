#' Plot a histogram of family score for the given family within pctid score intervals
#'
#'
#' @param  serratus serattus S4 object with family data frame
#' @param  family_name name of the family
#' @param title title of the plot
#'
#' @return ggplot
#'
#' @examples
#' 
#' scoreInPctidIntervals(ZOO, "Coronaviridae", title="Coronaviridae in ZOO")
#' 
#' @export
#'
scoreInPctidIntervals <- function(serratus, family_name, title=""){
  family_df <- serratus@family %>% filter(family %in% c(family_name))
  
  test <- family_df$pctid
  test2 <- sapply(test, function(x){
    if ((x <= 100) & (x > 97)){
      return("97-100")
    } else if ((x <= 97) & (x > 94)){
      return("94-97")
    } else if ((x <= 94) & (x > 91)){
      return("91-94")
    } else if ((x <= 91) & (x > 88)){
      return("88-91")
    } else if ((x <= 88) & (x > 85)){
      return("85-88")
    } else if ((x <= 85) & (x > 82)){
      return("82-85")
    } else {
      return("<82")
    }
  })
  
  test2 <- factor(test2, levels = c("<82", "82-85", "85-88", "88-91", "91-94", "94-97", "97-100"))
  
  family_df$pctid_intervals <- test2
  
  p <- ggplot(family_df %>% group_by(score,pctid_intervals) %>% summarize(n=n(), log10n = log10(n() + 1)), 
         aes(score, log10n,fill = pctid_intervals)) +
    geom_bar(color="black",stat = "identity") +
    scale_fill_viridis(discrete=TRUE) + 
    theme_bw() +
    labs(title = title)
  
  return(p)
}