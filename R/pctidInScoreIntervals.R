#' Plot a histogram of pctid for the given family within family score intervals
#'
#'
#' @param  family_df family data frame
#' @param  family_name name of the family
#' @param title title of the plot
#'
#' @return ggplot
#'
#' @examples
#' 
#' pctidInScoreIntervals(ZOO, "Coronaviridae", title="Coronaviridae in ZOO")
#' 
#' @export
#'
pctidInScoreIntervals <- function(family_df, family_name, title=""){
  family_df <- family_df %>% filter(family %in% c(family_name))
  
  test <- family_df$score
  test2 <- sapply(test, function(x){
    if ((x <= 100) & (x > 95)){
      return("95-100")
    } else if ((x <= 95) & (x > 85)){
      return("85-95")
    } else if ((x <= 85) & (x > 75)){
      return("75-85")
    } else if ((x <= 75) & (x > 65)){
      return("65-75")
    } else if ((x <= 65) & (x > 55)){
      return("55-65")
    } else if ((x <= 55) & (x > 45)){
      return("45-55")
    } else if ((x <= 45) & (x > 35)){
      return("35-45")
    } else if ((x <= 35) & (x > 25)){
      return("25-35")
    } else if ((x <= 25) & (x > 15)){
      return("15-25")
    } else if ((x <= 15) & (x > 5)){
      return("5-15")
    } else {
      return("0-5")
    }
  })
  
  test2 <- factor(test2, levels = c("0-5", "5-15", "15-25", "25-35", "35-45", "45-55", "55-65", "65-75", "75-85", "85-95", "95-100"))
  
  family_df$score_intervals <- test2
  
  p <- ggplot(family_df %>% group_by(pctid,score_intervals) %>% summarize(n=n(), log10n = log10(n() + 1)), 
              aes(pctid, log10n,fill = score_intervals)) +
    geom_bar(color="black",stat = "identity") +
    scale_fill_viridis(discrete=TRUE) + 
    theme_bw() +
    labs(title = title)
  
  return(p)
}