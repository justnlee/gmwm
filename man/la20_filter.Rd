% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/RcppExports.R
\name{la20_filter}
\alias{la20_filter}
\title{la20 filter construction}
\usage{
la20_filter()
}
\value{
A \code{field<vec>} that contains:
\itemize{
 \item{"L"}{A \code{integer} specifying the length of the filter}
 \item{"h"}{A \code{vector} containing the coefficients for the wavelet filter}
 \item{"g"}{A \code{vector} containing the coefficients for the scaling filter}
}
}
\description{
Creates the la20 filter
}
\details{
This template can be used to increase the amount of filters available for selection.
}
\examples{
la20_filter()
}
\author{
JJB
}
\keyword{internal}

