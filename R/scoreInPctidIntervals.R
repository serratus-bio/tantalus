#' Plot a histogram of family score for the given family within pctid score intervals
#'
#'
#' @param  family_df family data frame
#' @param  family_name name of the family (single value)
#' @param title title of the plot
#' @param scale_log if plot log scale (not implemented)
#' @param bin_percent if split pctid into bins for plotting
#'
#' @return ggplot
#'
#' @examples
#' 
#' scoreInPctidIntervals(ZOO, "Coronaviridae", title="Coronaviridae in ZOO")
#' 
#' @export
#'
#scoreInPctidIntervals <- function(family_df, family_name, title=""){
scoreInPctidIntervals <- function(family_df, family_name=NULL, title="", scale_log = F, bin_percent = T){
  
  # Filter by input family name
  if (!is.null(family_name)){
    family_df <- family_df %>% filter(family %in% c(family_name))
  }
  
  if (bin_percent){
    Pctid_bins <- sapply(family_df$pctid, function(x){
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
    
    Pctid_bins <- factor(Pctid_bins, levels = c("<82", "82-85", "85-88", "88-91", "91-94", "94-97", "97-100"))
    
    family_df$pctid_intervals <- Pctid_bins
  } else {
    family_df$pctid_intervals <- factor(family_df$pctid)
  }
  
  # Reform DF around pctid_intervals
  family_df <- family_df %>% group_by(pctid_intervals, score, family) %>% summarize(n=n(), log10n = log10(n() + 1))
  
  #sort by family sizes
  #pointless if there is just one family
  sum_families <- aggregate(family_df$n, by=list(family=family_df$family), FUN=sum)
  sum_families <- setNames(sum_families$x, sum_families$family)
  sorted_families <- sort(sum_families, decreasing = T) 
  
  family_df <- transform(family_df, family = factor(family, levels = names(sorted_families)))
  family_df <- family_df[with(family_df, order(pctid_intervals, score, decreasing = T)), ]
  
  # Calculate cumulative sum for intervals
  # clusterfuck here
  sums <- aggregate(n ~ score, family_df, cumsum)
  sums <- unlist(sums$n)
  family_df$cumsum <- sums
  
  # Perform log calculations
  family_df$log10_old <- log10(family_df$cumsum+1)
  family_df <- family_df %>% group_by(score) %>% 
  mutate(log10n= cumm_difference(log10_old))
  
  #define the colorscale
  if (bin_percent){
    cc <- viridis(7)
    names(cc) <- c("<82", "82-85", "85-88", "88-91", "91-94", "94-97", "97-100")
  } else {
    cc <- viridis(101)
    names(cc) <- 0:100
  }
  
  
  if (scale_log){
    p <- c("TODO: LOG SCALE BROKEN")
    
  } else { 
    # Plot linear
    p <- ggplot(family_df, 
                aes(score, n, color = score, fill = pctid_intervals)) +
      geom_bar(color="black", stat = "identity") +
      theme_bw() +
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
