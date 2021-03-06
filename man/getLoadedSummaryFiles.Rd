% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/getLoadedSummaryFiles.R
\name{getLoadedSummaryFiles}
\alias{getLoadedSummaryFiles}
\title{getLoadedSummaryFiles}
\usage{
getLoadedSummaryFiles(sras, path_to_files = "")
}
\arguments{
\item{sras}{a string vector of the SRAs}

\item{path_to_files}{a local folder with the SRA summary files}
}
\value{
Serratus S4 class
}
\description{
Parses the specified list of SRA accessions (which are supposed to be present in the specified folder)
into a Serratus S4 object
}
\details{
Implicit system dependcies
- aws cli
}
