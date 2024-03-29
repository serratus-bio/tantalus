% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/getSraRunInfo.R
\name{getSraRunInfo}
\alias{getSraRunInfo}
\title{Downloads an SRA runInfo file and parses
into a RunInfo S4 object}
\usage{
getSraRunInfo(runInfo, s3_path = "s3://lovelywater2/sra/", local_path = "sra")
}
\arguments{
\item{runInfo}{a string of the name of the sraRunInfo.csv file}

\item{s3_path}{a string s3 path holding sraRunInfo.csv file}

\item{local_path}{local path into which to download the data [sra]}
}
\description{
Implicit system dependcies
- aws cli
}
\examples{
getRunInfo(runInfo = "viro_SraRunInfo.csv",
           s3_path = "s3://lovelywater2/sra/",
           local_path = "sra")

}
\keyword{S3,}
\keyword{Tantalus,}
\keyword{runInfo,}
\keyword{sra}
