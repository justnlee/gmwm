% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/misc.R
\name{addSpaceIfDuplicate}
\alias{addSpaceIfDuplicate}
\title{Add Space to Avoid Duplicate Elements}
\usage{
addSpaceIfDuplicate(x)
}
\arguments{
\item{x}{A \code{character vector}}
}
\description{
Add space to every element if there are duplicates in the vector.
}
\examples{
##no duplicate
x1 = c('GMWM2', 'GMWM1', 'GMWM3')
addSpaceIfDuplicate(x1)

##duplicate
x2 = c('GMWM3', 'GMWM4', 'GMWM3', 'GMWM4', 'GMWM5', 'GMWM6','GMWM3')
addSpaceIfDuplicate(x2)
}
\keyword{internal}

