# Copyright (C) 2014 - 2016  James Balamuta, Stephane Guerrier, Roberto Molinari
#
# This file is part of GMWM R Methods Package
#
# The `gmwm` R package is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# The `gmwm` R package is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

#' Create an Autoregressive 1 [AR(1)] Process
#'
#' Setups the necessary backend for the AR1 process.
#' @param phi A \code{double} value for the \eqn{\phi}{phi} of an AR1 process.
#' @param sigma2 A \code{double} value for the variance, \eqn{\sigma ^2}{sigma^2}, of a WN process.
#' @return An S3 object with called ts.model with the following structure:
#' \describe{
#'  \item{process.desc}{Used in summary: "AR1","SIGMA2"}
#'  \item{theta}{\eqn{\phi}{phi}, \eqn{\sigma^2}{sigma^2}}
#'  \item{plength}{Number of Parameters}
#'  \item{desc}{"AR1"}
#'  \item{obj.desc}{Depth of Parameters e.g. list(1,1)}
#'  \item{starting}{Guess Starting values? TRUE or FALSE (e.g. specified value)}
#' }
#' @author JJB
#' @examples
#' AR1()
#' AR1(phi=.32, sigma2=1.3)
AR1 = function(phi = NULL, sigma2 = 1) {
  starting = FALSE;
  if(is.null(phi)){
    phi = 0;
    sigma2 = 1;
    starting = TRUE;
  }
  if(length(phi) != 1 & length(sigma2) != 1){
    stop("Bad AR1 model submitted. Must be double values for two parameters.")
  }
  out = structure(list(process.desc = c("AR1","SIGMA2"),
                       theta = c(phi,sigma2),
                       plength = 2,
                       desc = "AR1",
                       obj.desc = list(c(1,1)),
                       starting = starting), class = "ts.model")
  invisible(out)
}

#' Create an Moving Average 1 [MA(1)] Process
#' 
#' Setups the necessary backend for the MA1 process.
#' @param theta  A \code{double} value for the \eqn{\phi}{phi} of an MA1 process.
#' @param sigma2 A \code{double} value for the variance, \eqn{\sigma ^2}{sigma^2}, of a WN process.
#' @return An S3 object with called ts.model with the following structure:
#' \describe{
#'  \item{process.desc}{Used in summary: "MA1","SIGMA2"}
#'  \item{theta}{\eqn{\theta}{theta}, \eqn{\sigma^2}{sigma^2}}
#'  \item{plength}{Number of Parameters}
#'  \item{desc}{"MA1"}
#'  \item{obj.desc}{Depth of Parameters e.g. list(1,1)}
#'  \item{starting}{Guess Starting values? TRUE or FALSE (e.g. specified value)}
#' }
#' @author JJB
#' @examples
#' MA1()
#' MA1(theta=.32, sigma2=1.3)
MA1 = function(theta = NULL, sigma2 = 1) {
  starting = FALSE;
  if(is.null(theta)){
    theta = 0;
    sigma2 = 1;
    starting = TRUE;
  }
  if(length(theta) != 1 & length(sigma2) != 1){
    stop("Bad MA1 model submitted. Must be double values for two parameters.")
  }
  out = structure(list(process.desc = c("MA1","SIGMA2"),
                       theta = c(theta,sigma2),
                       plength = 2,
                       desc = "MA1",
                       obj.desc = list(c(1,1)),
                       starting = starting), class = "ts.model")
  invisible(out)
}


#' Create an Autoregressive Order 1 - Moving Average Order 1 (ARMA(1,1)) Process
#' 
#' Sets up the necessary backend for the ARMA(1,1) process.
#' @param phi    A \code{double} containing the coefficients for \eqn{\phi _1}{phi[1]}'s for the Autoregressive 1 (AR1) term.
#' @param theta  A \code{double} containing  the coefficients for \eqn{\theta _1}{theta[1]}'s for the Moving Average 1 (MA1) term.
#' @param sigma2 A \code{double} value for the standard deviation, \eqn{\sigma}{sigma}, of the ARMA process.
#' @return An S3 object with called ts.model with the following structure:
#' \describe{
#'  \item{process.desc}{\eqn{AR1}, \eqn{MA1}, \eqn{SIGMA2}}
#'  \item{theta}{\eqn{\phi}{phi}, \eqn{\theta}{theta}, \eqn{\sigma^2}{sigma^2}}
#'  \item{plength}{Number of Parameters: 3}
#'  \item{obj.desc}{Depth of Parameters e.g. list(c(1,1,1))}
#'  \item{starting}{Guess Starting values? \code{TRUE} or \code{FALSE} (e.g. specified value)}
#' }
#' @details
#' A variance is required since the model generation statements utilize 
#' randomization functions expecting a variance instead of a standard deviation like R.
#' @author JJB
#' @examples
#' # Creates an ARMA(1,1) process with predefined coefficients.
#' ARMA11(phi = .23, theta = .1, sigma2 = 1)
#' 
#' # Creates an ARMA(1,1) process with values to be guessed on callibration.
#' ARMA11()
ARMA11 = function(phi = NULL, theta = NULL, sigma2 = 1.0) {
  # Assume the user specified data
  starting = FALSE
  
  if(is.null(phi) || is.null(theta)){
    phi = 0
    theta = 0;
    sigma2 = 1;
    starting = TRUE;
  }else if(length(phi) != 1 || length(theta) != 1){
    stop("`phi` and `theta` must have only one value.")
  }
  
  out = structure(list(process.desc = c("AR1","MA1","SIGMA2"),
                       theta = c(phi, theta, sigma2),
                       plength = 3,
                       desc = "ARMA11",
                       obj.desc = list(c(1,1,1)),
                       starting = starting), class = "ts.model")
  invisible(out)
}



#' Create a Gauss-Markov (GM) Process
#' 
#' Setups the necessary backend for the GM process.
#' @param beta A \code{double} value for the \eqn{\beta}{beta} of an GM process.
#' @param sigma2_gm A \code{double} value for the variance, \eqn{\sigma ^2_{gm}}{sigma^2[gm]}, of a WN process.
#' @return An S3 object with called ts.model with the following structure:
#' \describe{
#'  \item{process.desc}{Used in summary: "BETA","SIGMA2"}
#'  \item{theta}{\eqn{\beta}{beta}, \eqn{\sigma ^2_{gm}}{sigma^2[gm]}}
#'  \item{plength}{Number of Parameters}
#'  \item{desc}{"GM"}
#'  \item{obj.desc}{Depth of Parameters e.g. list(1,1)}
#'  \item{starting}{Guess Starting values? TRUE or FALSE (e.g. specified value)}
#' }
#' @details 
#' When supplying values for \eqn{\beta}{beta} and \eqn{\sigma ^2_{gm}}{sigma^2[gm]},
#' these parameters should be of a GM process and NOT of an AR1. That is,
#' do not supply AR1 parameters such as \eqn{\phi}{phi}, \eqn{\sigma^2}{sigma^2}.
#' 
#' Internally, GM parameters are converted to AR1 using the `freq` 
#' supplied when creating data objects (\link{imu}, \link{gts})
#' or specifying a `freq` parameter in \link{gmwm} or \link{gmwm.imu}.
#' 
#' The `freq` of a data object takes precedence over the `freq` set when modeling.
#' @author JJB
#' @examples
#' GM()
#' GM(beta=.32, sigma2_gm=1.3)
GM = function(beta = NULL, sigma2_gm = 1) {
  starting = FALSE;
  if(is.null(beta)){
    beta = 0;
    sigma2_gm = 1;
    starting = TRUE;
  }
  if(length(beta) != 1 & length(sigma2_gm) != 1){
    stop("Bad GM model submitted. Must be double values for two parameters.")
  }
  out = structure(list(process.desc = c("BETA","SIGMA2_GM"),
                       theta = c(beta,sigma2_gm),
                       plength = 2,
                       desc = "GM",
                       obj.desc = list(c(1,1)),
                       starting = starting), class = "ts.model")
  invisible(out)
}

#' Create an Quantisation Noise (QN) Process
#' 
#' Sets up the necessary backend for the QN process.
#' @param q2 A \code{double} value for the \eqn{Q^2}{Q^2} of a QN process.
#' @return An S3 object with called ts.model with the following structure:
#' \describe{
#'  \item{process.desc}{Used in summary: "QN"}
#'  \item{theta}{\eqn{Q^2}{Q^2}}
#'  \item{plength}{Number of Parameters}
#'  \item{desc}{y desc replicated x times}
#'  \item{obj.desc}{Depth of Parameters e.g. list(1)}
#'  \item{starting}{Guess Starting values? TRUE or FALSE (e.g. specified value)}
#' }
#' @author JJB
#' @examples
#' QN()
#' QN(q2=3.4)
QN = function(q2 = NULL) {
  starting = FALSE
  if(is.null(q2)){
    q2 = 2
    starting = TRUE
  }
  if(length(q2) != 1){
    stop("Bad QN model submitted. Must be a double that indicates the Q2 value.")
  }
  out = structure(list(process.desc = "QN",
                       theta = q2,
                       plength = 1,
                       desc = "QN",
                       obj.desc = list(1),
                       starting = starting), class = "ts.model")
  invisible(out)
}

#' Create an White Noise (WN) Process
#' 
#' Sets up the necessary backend for the WN process.
#' @param sigma2 A \code{double} value for the variance, \eqn{\sigma ^2}{sigma^2}, of a WN process.
#' @return An S3 object with called ts.model with the following structure:
#' \describe{
#'  \item{process.desc}{Used in summary: "WN"}
#'  \item{theta}{\eqn{\sigma}{sigma}}
#'  \item{plength}{Number of Parameters}
#'  \item{desc}{y desc replicated x times}
#'  \item{obj.desc}{Depth of Parameters e.g. list(1)}
#'  \item{starting}{Guess Starting values? TRUE or FALSE (e.g. specified value)}
#' }
#' @author JJB
#' @examples
#' WN()
#' WN(sigma2=3.4)
WN = function(sigma2 = NULL) {
  starting = FALSE
  if(is.null(sigma2)){
    sigma2 = 3
    starting = TRUE
  }
  if(length(sigma2) != 1){
    stop("Bad WN model submitted. Must be a double that indicates the standard deviation.")
  }
  out = structure(list(process.desc = "WN",
                       theta = sigma2,
                       plength = 1,
                       desc = "WN",
                       obj.desc = list(1),
                       starting = starting), class = "ts.model")
  invisible(out)
}

#' Create an Random Walk (RW) Process
#' 
#' Sets up the necessary backend for the RW process.
#' @param gamma2 A \code{double} value for the variance \eqn{\gamma ^2}{gamma^2}
#' @return An S3 object with called ts.model with the following structure:
#' \describe{
#'  \item{process.desc}{Used in summary: "RW"}
#'  \item{theta}{\eqn{\sigma}{sigma}}
#'  \item{plength}{Number of Parameters}
#'  \item{desc}{y desc replicated x times}
#'  \item{obj.desc}{Depth of Parameters e.g. list(1)}
#'  \item{starting}{Guess Starting values? TRUE or FALSE (e.g. specified value)}
#' }
#' @author JJB
#' @examples
#' RW()
#' RW(gamma2=3.4)
RW = function(gamma2 = NULL) {
  starting = FALSE
  if(is.null(gamma2)){
    gamma2 = 4
    starting = TRUE
  }
  if(length(gamma2) != 1){
    stop("Bad RW model submitted. Must be a double that indicates the standard deviation.")
  }
  out = structure(list(process.desc = "RW",
                       theta = gamma2,
                       plength = 1,
                       desc = "RW",
                       obj.desc = list(1),
                       starting = starting), class = "ts.model")
  invisible(out)
}

#' Create an Drift (DR) Process
#' 
#' Sets up the necessary backend for the DR process.
#' @param omega A \code{double} value for the slope of a DR process.
#' @return An S3 object with called ts.model with the following structure:
#' \describe{
#'  \item{process.desc}{Used in summary: "DR"}
#'  \item{theta}{slope}
#'  \item{plength}{Number of Parameters}
#'  \item{obj.desc}{y desc replicated x times}
#'  \item{obj}{Depth of Parameters e.g. list(1)}
#'  \item{starting}{Guess Starting values? TRUE or FALSE (e.g. specified value)}
#' }
#' @author JJB
#' @examples
#' DR()
#' DR(omega=3.4)
DR = function(omega = NULL) {
  starting = FALSE
  if(is.null(omega)){
    omega = 5
    starting = TRUE
  }
  if(length(omega) != 1){
    stop("Bad Drift model submitted. Must be a double that indicates a slope.")
  }
  out = structure(list(process.desc = "DR",
                       theta = omega,
                       plength = 1,
                       desc = "DR",
                       obj.desc = list(1),
                       starting = starting), class = "ts.model")
  invisible(out)
}



#' @title Create an Autoregressive P [AR(P)] Process
#' @description Setups the necessary backend for the AR(P) process.
#' @param phi A \code{vector} with double values for the \eqn{\phi}{phi} of an AR(P) process.
#' @param sigma2 A \code{double} value for the variance, \eqn{\sigma ^2}{sigma^2}, of a WN process.
#' @return An S3 object with called ts.model with the following structure:
#' \describe{
#'  \item{process.desc}{Used in summary: "AR-1","AR-2", ..., "AR-P", "SIGMA2"}
#'  \item{theta}{\eqn{\phi_1}{phi[[1]]}, \eqn{\phi_2}{phi[[2]]}, ..., \eqn{\phi_p}{phi[[p]]}, \eqn{\sigma^2}{sigma^2}}
#'  \item{plength}{Number of Parameters}
#'  \item{desc}{"AR"}
#'  \item{obj.desc}{Depth of Parameters e.g. list(p,1)}
#'  \item{starting}{Guess Starting values? TRUE or FALSE (e.g. specified value)}
#' }
#' @author JJB
#' @examples
#' AR(1) # Slower version of AR1()
#' AR(phi=.32, sigma=1.3) # Slower version of AR1()
#' AR(2) # Equivalent to ARMA(2,0).
AR = function(phi = NULL, sigma2 = 1) {
  
  if(is.null(phi)){
    stop("`phi` must either be a whole number or a vector of numbers for phi parameter in AR().")
  }
  
  out = SARIMA(ar = phi, i = 0,  ma = 0, sar = 0, si = 0,  sma = 0, s = 0, sigma2 = sigma2)

  invisible(out)
}


#' Create an Moving Average Q [MA(Q)] Process
#' 
#' Setups the necessary backend for the MA(Q) process.
#' @param theta A \code{vector} with double values for the \eqn{\theta}{theta} of an MA(Q) process.
#' @param sigma2 A \code{double} value for the variance, \eqn{\sigma ^2}{sigma^2}, of a WN process.
#' @return An S3 object with called ts.model with the following structure:
#' \describe{
#'  \item{process.desc}{Used in summary: "MA-1","MA-2", ..., "MA-Q", "SIGMA2"}
#'  \item{theta}{\eqn{\theta_1}{theta[[1]]}, \eqn{\theta_2}{theta[[2]]}, ..., \eqn{\theta_q}{theta[[q]]}, \eqn{\sigma^2}{sigma^2}}
#'  \item{plength}{Number of Parameters}
#'  \item{desc}{"MA"}
#'  \item{obj.desc}{Depth of Parameters e.g. list(q,1)}
#'  \item{starting}{Guess Starting values? TRUE or FALSE (e.g. specified value)}
#' }
#' @author JJB
#' @examples
#' MA(1) # One theta
#' MA(2) # Two thetas!
#' 
#' MA(theta=.32, sigma=1.3) # 1 theta with a specific value.
#' MA(theta=c(.3,.5), sigma=.3) # 2 thetas with specific values.
MA = function(theta = NULL, sigma2 = 1) {
  if(is.null(theta)){
    stop("`theta` must be either a whole number or a vector of doubles for theta parameter in MA().")
  }
  
  out = SARIMA(ar = 0, i = 0,  ma = theta, sar = 0, si = 0,  sma = 0, s = 0, sigma2 = sigma2)

  invisible(out)
}


#' @title Create an Autoregressive Moving Average (ARMA) Process
#' @description Sets up the necessary backend for the ARMA process.
#' @param ar A \code{vector} or \code{integer} containing either the coefficients for \eqn{\phi}{phi}'s or the process number \eqn{p} for the Autoregressive (AR) term.
#' @param ma A \code{vector} or \code{integer} containing either the coefficients for \eqn{\theta}{theta}'s or the process number \eqn{q} for the Moving Average (MA) term.
#' @param sigma2 A \code{double} value for the standard deviation, \eqn{\sigma}{sigma}, of the ARMA process.
#' @return An S3 object with called ts.model with the following structure:
#' \describe{
#'  \item{process.desc}{\eqn{AR*p}{AR x p}, \eqn{MA*q}{MA x q}}
#'  \item{theta}{\eqn{\sigma}{sigma}}
#'  \item{plength}{Number of Parameters}
#'  \item{obj.desc}{y desc replicated x times}
#'  \item{obj}{Depth of Parameters e.g. list(c(length(ar),length(ma),1) )}
#'  \item{starting}{Guess Starting values? TRUE or FALSE (e.g. specified value)}
#' }
#' @details
#' A variance is required since the model generation statements utilize 
#' randomization functions expecting a variance instead of a standard deviation like R.
#' @author JJB
#' @examples
#' # Create an ARMA(1,2) process
#' ARMA(ar=1,2)
#' # Creates an ARMA(3,2) process with predefined coefficients.
#' ARMA(ar=c(0.23,.43, .59), ma=c(0.4,.3))
#' 
#' # Creates an ARMA(3,2) process with predefined coefficients and standard deviation
#' ARMA(ar=c(0.23,.43, .59), ma=c(0.4,.3), sigma2 = 1.5)
ARMA = function(ar = 1, ma = 1, sigma2 = 1.0) {
  out = SARIMA(ar = ar, i = 0,  ma = ma, sar = 0, si = 0,  sma = 0, s = 0, sigma2 = sigma2)
  
  invisible(out)
}


#' @title Create an Autoregressive Integrated Moving Average (ARIMA) Process
#' @description Sets up the necessary backend for the ARIMA process.
#' @param ar     A \code{vector} or \code{integer} containing either the coefficients for \eqn{\phi}{phi}'s or the process number \eqn{p} for the Autoregressive (AR) term.
#' @param i      An \code{integer} containing the number of differences to be done.
#' @param ma     A \code{vector} or \code{integer} containing either the coefficients for \eqn{\theta}{theta}'s or the process number \eqn{q} for the Moving Average (MA) term.
#' @param sigma2 A \code{double} value for the standard deviation, \eqn{\sigma}{sigma}, of the ARIMA process.
#' @return An S3 object with called ts.model with the following structure:
#' \describe{
#'  \item{process.desc}{\eqn{AR*p}{AR x p}, \eqn{MA*q}{MA x q}}
#'  \item{theta}{\eqn{\sigma}{sigma}}
#'  \item{plength}{Number of Parameters}
#'  \item{obj.desc}{y desc replicated x times}
#'  \item{obj}{Depth of Parameters e.g. list(c(length(ar),length(ma),1) )}
#'  \item{starting}{Guess Starting values? TRUE or FALSE (e.g. specified value)}
#' }
#' @details
#' A variance is required since the model generation statements utilize 
#' randomization functions expecting a variance instead of a standard deviation like R.
#' @author JJB
#' @examples
#' # Create an ARMA(1,2) process
#' ARIMA(ar=1,2)
#' # Creates an ARMA(3,2) process with predefined coefficients.
#' ARIMA(ar=c(0.23,.43, .59), ma=c(0.4,.3))
#' 
#' # Creates an ARMA(3,2) process with predefined coefficients and standard deviation
#' ARIMA(ar=c(0.23,.43, .59), ma=c(0.4,.3), sigma2 = 1.5)
ARIMA = function(ar = 1, i = 0, ma = 1, sigma2 = 1.0) {
  out = SARIMA(ar = ar, i = i,  ma = ma, sar = 0, si = 0,  sma = 0, s = 0, sigma2 = sigma2)
  
  invisible(out)
}

#' @title Create a Seasonal Autoregressive Moving Average (SARMA) Process
#' @description Sets up the necessary backend for the SARMA process.
#' @param ar A \code{vector} or \code{integer} containing either the coefficients for \eqn{\phi}{phi}'s or the process number \eqn{p} for the Autoregressive (AR) term.
#' @param ma A \code{vector} or \code{integer} containing either the coefficients for \eqn{\theta}{theta}'s or the process number \eqn{q} for the Moving Average (MA) term.
#' @param sar A \code{vector} or \code{integer} containing either the coefficients for \eqn{\Phi}{PHI}'s or the process number \eqn{P} for the Seasonal Autoregressive (SAR) term.
#' @param sma A \code{vector} or \code{integer} containing either the coefficients for \eqn{\Theta}{THETA}'s or the process number \eqn{Q} for the Seasonal Moving Average (SMA) term.
#' @param s   A \code{integer} indicating the seasonal value of the data.
#' @param sigma2 A \code{double} value for the standard deviation, \eqn{\sigma}{sigma}, of the SARMA process.
#' @return An S3 object with called ts.model with the following structure:
#' \describe{
#'  \item{process.desc}{\eqn{AR*p}{AR x p}, \eqn{MA*q}{MA x q}, \eqn{SAR*P}{SAR x P}, \eqn{SMA*Q}{SMA x Q}}
#'  \item{theta}{\eqn{\sigma}{sigma}}
#'  \item{plength}{Number of Parameters}
#'  \item{obj.desc}{y desc replicated x times}
#'  \item{obj}{Depth of Parameters e.g. list(c(length(ar), length(ma), length(sar), length(sma), 1) )}
#'  \item{starting}{Guess Starting values? TRUE or FALSE (e.g. specified value)}
#' }
#' @details
#' A variance is required since the model generation statements utilize 
#' randomization functions expecting a variance instead of a standard deviation unlike R.
#' @author JJB
#' @examples
#' # Create an SARMA(1,2)x(1,1) process
#' SARMA(ar = 1, ma = 2,sar = 1, sma =1)
#' 
#' # Creates an SARMA(1,1)x(1,1) process with predefined coefficients.
#' SARMA(ar=0.23, ma=0.4, sar = .3, sma = .3)
SARMA = function(ar = 1, ma = 1, sar = 1, sma = 1, s = 12, sigma2 = 1.0) {
  
  out = SARIMA(ar = ar, i = 0,  ma = ma, sar = sar, si = 0,  sma = sma, s = 12, sigma2 = sigma2)
  
  invisible(out)
}


#' @title Create a Seasonal Autoregressive Integrated Moving Average (SARIMA) Process
#' @description Sets up the necessary backend for the SARIMA process.
#' @param ar  A \code{vector} or \code{integer} containing either the coefficients for \eqn{\phi}{phi}'s or the process number \eqn{p} for the Autoregressive (AR) term.
#' @param i   An \code{integer} containing the number of differences to be done.
#' @param ma  A \code{vector} or \code{integer} containing either the coefficients for \eqn{\theta}{theta}'s or the process number \eqn{q} for the Moving Average (MA) term.
#' @param sar A \code{vector} or \code{integer} containing either the coefficients for \eqn{\Phi}{PHI}'s or the process number \eqn{P} for the Seasonal Autoregressive (SAR) term.
#' @param si  An \code{integer} containing the number of seasonal differences to be done.
#' @param sma A \code{vector} or \code{integer} containing either the coefficients for \eqn{\Theta}{THETA}'s or the process number \eqn{Q} for the Seasonal Moving Average (SMA) term.
#' @param s   An \code{integer} containing the seasonality.
#' @param sigma2 A \code{double} value for the standard deviation, \eqn{\sigma}{sigma}, of the SARMA process.
#' @return An S3 object with called ts.model with the following structure:
#' \describe{
#'  \item{process.desc}{\eqn{AR*p}{AR x p}, \eqn{MA*q}{MA x q}, \eqn{SAR*P}{SAR x P}, \eqn{SMA*Q}{SMA x Q}}
#'  \item{theta}{\eqn{\sigma}{sigma}}
#'  \item{plength}{Number of Parameters}
#'  \item{obj.desc}{y desc replicated x times}
#'  \item{obj}{Depth of Parameters e.g. list(c(length(ar), length(ma), length(sar), length(sma), 1, i, si) )}
#'  \item{starting}{Guess Starting values? TRUE or FALSE (e.g. specified value)}
#' }
#' @details
#' A variance is required since the model generation statements utilize 
#' randomization functions expecting a variance instead of a standard deviation unlike R.
#' @author JJB
#' @examples
#' # Create an SARIMA(1,1,2)x(1,0,1) process
#' SARIMA(ar = 1, i = 1, ma = 2, sar = 1, si = 0, sma =1)
#' 
#' # Creates an SARMA(1,0,1)x(1,1,1) process with predefined coefficients.
#' SARIMA(ar=0.23, i = 0, ma=0.4, sar = .3,  sma = .3)
SARIMA = function(ar = 1, i = 0,  ma = 1, sar = 1, si = 0,  sma = 1, s = 12, sigma2 = 1.0) {
  # Assume the user specified data
  starting = FALSE
  
  # Get initial parameters
  p = length(ar)
  q = length(ma)
  
  P = length(sar)
  Q = length(sma)
  
  
  d = length(i)
  ds = length(si)
  
  if(d > 1 || ds > 1){stop("`i` or `si` must have a length of 1.")}
  else if(!is.whole(i) || !is.whole(si)){stop("`i` or `si` must be integers.")}
  
  
  # If P or Q == 1, this implies we might have a starting guess. 
  if( p == 1 || q == 1 || P == 1 || Q == 1 ){
    if(p == 1){
      if(is.whole(ar) & ar != 0){
        ar = rep(-1, ar)
        starting = TRUE
      }else if(ar == 0){
        ar = numeric(0) # creates a size 0 vector
      }
    }
    
    if(q == 1){
      if(is.whole(ma) & ma != 0){
        ma = rep(-2, ma)
        starting = TRUE
      }else if(ma == 0){
        ma = numeric(0) 
      }
    }
    
    if(P == 1){
      if(is.whole(sar) & sar != 0){
        sar = rep(-1, sar)
        starting = TRUE
      }else if(sar == 0){
        sar = numeric(0) # creates a size 0 vector
      }
    }
    
    if(Q == 1){
      if(is.whole(sma) & sma != 0){
        sma = rep(-2, sma)
        starting = TRUE
      }else if(sma == 0){
        sma = numeric(0) 
      }
    }
  }
  
  # Update the values.
  p = length(ar)
  q = length(ma)
  
  P = length(sar)
  Q = length(sma)
  
  out = structure(list(process.desc = c(rep("AR", p), rep("MA",q), rep("SAR", P), rep("SMA",Q), "SIGMA2"),
                       theta = c(ar, ma, sar, sma, sigma2),
                       plength = p + q + P + Q + 1,
                       desc = "SARIMA",
                       obj.desc = list(c(p, q, P, Q, 1, s, i, si)),
                       starting = starting), class = "ts.model")
  invisible(out)
}


#' @title Multiple a ts.model by constant
#' @description Sets up the necessary backend for creating multiple model objects.
#' @method * ts.model
#' @param x A \code{numeric} value
#' @param y A \code{ts.model} object
#' @return An S3 object with called ts.model with the following structure:
#' \describe{
#'  \item{process.desc}{y desc replicated x times}
#'  \item{theta}{y theta replicated x times}
#'  \item{plength}{Number of Parameters}
#'  \item{desc}{y desc replicated x times}
#'  \item{obj.desc}{Depth of Parameters e.g. list(c(1,1),c(1,1))}
#'  \item{starting}{Guess Starting values? TRUE or FALSE (e.g. specified value)}
#' }
#' @author JJB
#' @keywords internal
#' @export
#' @examples
#' 4*DR()+2*WN()
#' DR()*4 + WN()*2
#' AR1(phi=.3,sigma=.2)*3
`*.ts.model` = function(x, y) {
  # Handles the ts.model()*c case
  if(!is.numeric(x)){
    temp = x
    x = y
    y = temp
  }
  out = structure(list(process.desc = rep(y$process.desc,x),
                       theta = rep(y$theta,x),
                       plength = y$plength*x,
                       desc = rep(y$desc,x),
                       obj.desc = rep(y$obj.desc,x),
                       starting = y$starting), class = "ts.model")
  invisible(out)
}

#' @title Add ts.model objects together
#' @description Sets up the necessary backend for combining ts.model objects.
#' @method + ts.model
#' @param x A \code{ts.model} object
#' @param y A \code{ts.model} object
#' @return An S3 object with called ts.model with the following structure:
#' \itemize{
#'  \item{process.desc}{combined x, y desc}
#'  \item{theta}{combined x, y theta}
#'  \item{plength}{Number of Parameters}
#'  \item{desc}{Add process to queue e.g. c("AR1","WN")}
#'  \item{obj.desc}{Depth of Parameters e.g. list(1, c(1,1), c(length(ar),length(ma),1) )}
#'  \item{starting}{Guess Starting values? TRUE or FALSE (e.g. specified value)}
#' }
#' @author JJB
#' @export
#' @keywords internal
#' @examples
#' DR()+WN()
#' AR1(phi=.3,sigma=.2)
`+.ts.model` = function(x, y) {
  starting = FALSE
  if(y$starting & x$starting){
    starting = TRUE
  }
  out = structure(list(process.desc = c(x$process.desc, y$process.desc),
                       theta = c(x$theta,y$theta),
                       plength = x$plength + y$plength,
                       desc = c(x$desc, y$desc),
                       obj.desc = c(x$obj.desc, y$obj.desc),
                       starting = starting), class = "ts.model")
  invisible(out)
}

#' @title Multiple a ts.model by constant
#' @description Sets up the necessary backend for creating multiple model objects.
#' @method print ts.model
#' @export
#' @param x A \code{numeric} value
#' @param ... further arguments passed to or from other methods.
#' @return An S3 object with called ts.model with the following structure:
#' \itemize{
#'  \item{desc}
#'  \item{theta}
#' }
#' @keywords internal
#' @author JJB
#' @examples
#' # Creates a parameter space for guessing
#' QN() + DR() + WN() + RW() + AR1() + ARMA(1,2)
#' 
#' # Creates a user-specified starting value model
#' AR1(phi = .9, sigma2 = .1) + WN(sigma2 = 1) 
#' 
#' # Similarly, with the addition of a generic ARMA
#' RW(gamma2 = .3) + DR(omega = .5) + QN(q2 = .9) + ARMA(ar = c(.3,.1), ma = c(.3,.2), sigma2 = .99)
#' 
#' # In a similar vein, this example highlights the lack of need for specifying parameters. 
#' AR1(.9,.1) + WN(1) + RW(.3) + DR(.5) + QN(.9) + ARMA(c(.3,.1), c(.3,.2), .99)
print.ts.model = function(x, ...){

  desctable = data.frame("Terms" = x$process.desc, "Initial Values" = x$theta, stringsAsFactors = FALSE);
  cat("\nGuess Starting Values:", x$starting, "\n")
  if(x$starting){
    cat("The program will attempt to guess starting values for...\n")
    print(desctable[,1], row.names = FALSE)
    cat("To have the option of using your own starting values, please supply values for each parameter.\n")
  }else{
    print(desctable, row.names = FALSE)
    cat("The model will be initiated using the initial values you supplied.\n")
  }
}

#' @title Create a ts.model from desc string
#' @description Sets up the necessary backend for using Cpp functions to build R ts.model objects
#' @param desc A \code{character} vector containing: \code{"AR1"},\code{"DR"},\code{"WN"},\code{"RW"},\code{"QN"}
#' @return An S3 object with called ts.model with the following structure:
#' \itemize{
#'  \item{desc}
#'  \item{theta}
#' }
#' @author JJB
#' @keywords internal
#' @examples
#' desc.to.ts.model(c("AR1","WN"))
desc.to.ts.model = function(desc){
  theta = .Call('gmwm_model_theta', PACKAGE = 'gmwm', desc)
  
  out = structure(list(process.desc = .Call('gmwm_model_process_desc', PACKAGE='gmwm', desc),
                       theta = theta,
                       plength = length(theta),
                       desc = desc,
                       obj.desc = .Call('gmwm_model_objdesc', PACKAGE = 'gmwm', desc),
                       starting = TRUE), class = "ts.model")
  invisible(out)
}