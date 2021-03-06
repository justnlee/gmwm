% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/gmwm.R
\name{compare_models}
\alias{compare_models}
\title{Graphically Compare GMWM Model Fit}
\usage{
compare_models(..., display.model = T, show.theo.wv = F,
  facet.label = NULL, background = "white", transparence = 0.05,
  CI.color = NULL, line.color = NULL, line.type = NULL,
  point.size = NULL, point.shape = NULL,
  title = "Comparison of GMWM Models", title.size = 18,
  axis.label.size = 16, axis.tick.size = 11, facet.label.size = 13,
  facet.label.background = "#003C7D33",
  axis.x.label = expression(paste("Scale ", tau)),
  axis.y.label = expression(paste("Wavelet Variance ", nu)))
}
\arguments{
\item{...}{Several \code{gmwm} objects.}

\item{display.model}{A \code{boolean} indicating whether the model should be displayed in the facet label.}

\item{show.theo.wv}{A \code{boolean} indicating whether the theoretical WV should be plotted in the lower triangular area. See \code{details}.}

\item{facet.label}{A \code{character vector} indicating what should be displayed in the facet labels.}

\item{background}{A \code{string} that determines the graph background. It can be \code{'grey'} or \code{'white'}.}

\item{transparence}{A \code{double} that ranges from 0 to 1 that controls the transparency of confidence interval.}

\item{CI.color}{A \code{vector} of \code{string} that indicates the color of the confidence interval.}

\item{line.color}{A \code{vector} of \code{string} that indicates the color of lines.}

\item{line.type}{A \code{vector} of \code{string} that indicates the type of lines.}

\item{point.size}{A \code{vector} of \code{integer} that indicates the size of points on lines.}

\item{point.shape}{A \code{vector} of \code{integer} that indicates the shape of points on lines.}

\item{title}{A \code{string} that indicates the title of the graph.}

\item{title.size}{An \code{integer} that indicates the size of title.}

\item{axis.label.size}{An \code{integer} that indicates the size of label.}

\item{axis.tick.size}{An \code{integer} that indicates the size of tick mark.}

\item{facet.label.size}{An \code{integer} that indicates the size of facet label.}

\item{facet.label.background}{A \code{string} that indicates the background color of the facet label.}

\item{axis.x.label}{A \code{string} that indicates the label on x axis.}

\item{axis.y.label}{A \code{string} that indicates the label on y axis.}
}
\value{
A ggplot2 panel containing the graphs of gmwm objects.
}
\description{
Creates a table of graphs to compare GMWM model fit.
}
\details{
This function has been updated to deal with any \code{gmwm} object. The old contraint that supplied
objects must be constrcuted by the same data is no longer needed.

The parameter \code{show.theo.wv} will be automatically set to TRUE, if the supplied \code{gmwm} objects
are constructed by the same data. This aims to mimic the behaviour in the old version of \code{compare_models}.

The default aesthetical setting is designed to work well with 2 and 3 objects. Users are expected to change
the color/point/line settings if they want to supply more than 3 objects.

If two models have the same attribute values, for example, same empirical WV, then their aethetics will
be set to the same, i.e. same line type, line color, point size, point shape, etc.
}
\examples{
\dontrun{
#AR
set.seed(8836)
x1 = gen_gts(1000, AR1(phi = .1, sigma2 = 1) + AR1(phi = 0.95, sigma2 = .1))
x2 = gen_gts(2000, AR1(phi = .1, sigma2 = 1) + AR1(phi = 0.95, sigma2 = .1))

GMWM1 = gmwm(AR1(), data = x1)
GMWM2 = gmwm(2*AR1(), data = x2)

compare_models(GMWM1, GMWM2, show.theo.wv = T, transparence = 0.2, 
               facet.label = c('model1', 'model2'))
               
compare_models(GMWM1, GMWM2, CI.color = c('black','red'), 
               point.size = c(3, 3, 0, 0, 0, 0, 2, 2),
               line.color = c('black', 'red', 'grey', 'pink',
                              'grey', 'pink', 'purple', 'green')) 
#in the order of emp. WV, lower bound, higher bound, theo. WV
}
}
\author{
Wenchao
}

