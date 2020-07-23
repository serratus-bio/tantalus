#' Plot a histogram of pctid for the given family within family score intervals
#'
#'
#' @param  family_df family data frame
#' @param  family_name name of the family (single value)
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

pctidInScoreIntervals <- function(family_df, family_name=NULL, title="", scale_log = F, bin_scores = T){
  
  # Testing
  #family_df   <- CoV
  #family_name <- "Coronaviridae"
  
  # Filter by input family name
  if (!is.null(family_name)){
    family_df <- family_df %>% filter(family %in% c(family_name))
  }
  
  # Bin scores
  if (bin_scores){
    Scores_bin <- sapply(family_df$score, function(x){
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
    
    Scores_bin <- factor(Scores_bin,
                         levels = c("0-5", "5-15", "15-25", "25-35",
                                    "35-45", "45-55", "55-65", "65-75",
                                    "75-85", "85-95", "95-100")) 
    
    # Replace scores with score_bin for easier discrete categories
    family_df$score <- Scores_bin
  } else {
    family_df$score <- factor(family_df$score)
  }
  
  # Reform DF around Score
  family_df <- family_df %>% group_by(pctid, score, family) %>% summarize(n=n(), log10n = log10(n() + 1))
  
  #sort by family sizes
  #pointless if there is just one family
  sum_families <- aggregate(family_df$n, by=list(family=family_df$family), FUN=sum)
  sum_families <- setNames(sum_families$x, sum_families$family)
  sorted_families <- sort(sum_families, decreasing = T) 
  
  family_df <- transform(family_df, family = factor(family, levels = names(sorted_families)))
  family_df <- family_df[with(family_df, order(pctid, score, decreasing = T)), ]
  
  # Calculate cumulative sum for intervals
  # clusterfuck here
  sums <- aggregate(n ~ pctid, family_df, cumsum)
  sums <- unlist(sums$n)
  family_df$cumsum <- sums
  
  # Perform log calculations
  family_df$log10_old <- log10(family_df$cumsum+1)
  family_df <- family_df %>% group_by(pctid) %>% 
  mutate(log10n= cumm_difference(log10_old))
  
  #define the colorscale
  cc <- viridis(101)
  names(cc) <- 0:100
  
  if (scale_log){
    # Plot log-scaled
    p <- ggplot(family_df, 
                aes(pctid, log10n, color = score, fill = score)) +
      geom_bar(stat = "identity") +
      #scale_fill_viridis(discrete=TRUE) + 
      #scale_color_viridis(discrete=TRUE) + 
      theme_bw() + xlim(c(75,101)) +
      labs(title = title) +
      scale_colour_manual(values=cc) +
      scale_fill_manual(values=cc) 
    
    p <- c("TODO: LOG SCALE BROKEN")
    
  } else { 
    # Plot linear
    p <- ggplot(family_df, 
                aes(pctid, n, color = score, fill = score)) +
      geom_bar(stat = "identity") +
      #scale_fill_viridis(discrete=TRUE) + 
      #scale_color_viridis(discrete=TRUE) + 
      theme_bw() + xlim(c(75,101)) +
      labs(title = title) +
      scale_colour_manual(values=cc) +
      scale_fill_manual(values=cc) 
  }
  return(p)
}

#helping function for cumulative difference
cumm_difference <- function(vec){
  test <- c(vec[1], vec[-1] - vec[-length(vec)])
  return(test)
}
