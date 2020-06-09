#' Plot a histogram of percentage identity for a given family
#'
#'
#' @param  serratus serattus S4 object with family data frame
#' @param  family_name name of the family
#' @param  score_threshold don't consider family hits with score below this value (0 by default)
#' @param  x1 left limit on x axis
#' @param  x2 right limit on x axis
#' @param log log10 y axis or not (default F)
#'
#' @return ggplot
#'
#' @examples
#' 
#' familyPctID(ZOO, "Coronaviridae", score_threshold = 50, title="", x1=75, x2=100)
#' 
#' @export
#'
familyPctID <- function(serratus, family_name, score_threshold = 0, title="", x1=0, x2=100, log=F){
  family_df <- serratus@family %>% filter(family %in% c(family_name))
  
  if (log==F){
    p <- ggplot(data=family_df[which(family_df$score >= score_threshold), ], aes(pctid)) + 
      geom_histogram(fill="blue", bins = 30) +
      theme_bw() + 
      coord_cartesian(xlim=c(x1,x2)) +
      labs(x = "Percentage Identity") +
      labs(title = title)
  } else {
    p <- ggplot(data=family_df[which(family_df$score >= score_threshold), ], aes(pctid)) + 
      geom_histogram(fill="blue", bins = 30) +
      theme_bw() + 
      coord_cartesian(xlim=c(x1,x2)) +
      scale_y_log10() +
      labs(x = "Percentage Identity") +
      labs(title = title)
  }
  
  return(p)
}