% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/scoreInPctidIntervals.R
\name{scoreInPctidIntervals}
\alias{scoreInPctidIntervals}
\title{Plot a histogram of family score for the given family within pctid score intervals}
\usage{
scoreInPctidIntervals(
  family_df,
  family_name = NULL,
  title = "",
  scale_log = F,
  bin_percent = T
)
}
\arguments{
\item{family_df}{family data frame}

\item{family_name}{name of the family (single value)}

\item{title}{title of the plot}

\item{scale_log}{if plot log scale (not implemented)}

\item{bin_percent}{if split percent_identity into bins for plotting}
}
\value{
ggplot
}
\description{
Plot a histogram of family score for the given family within pctid score intervals
}
\examples{

scoreInPctidIntervals(ZOO, "Coronaviridae", title="Coronaviridae in ZOO")

}
