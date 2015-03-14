#include <RcppArmadillo.h>
#include "process_to_wv.h"

// Required for ARMA to WV process
#include "rtoarmadillo.h"

// Need square
#include "inline_functions.h"

using namespace Rcpp;

/* ----------------------------- Start Process to WV Functions ------------------------------- */

//' @title ARMA process to WV
//' @description This function computes the (haar) WV of an ARMA process
//' @param ar A \code{vec} containing the coefficients of the AR process
//' @param ma A \code{vec} containing the coefficients of the MA process
//' @param tau A \code{vec} containing the scales e.g. 2^tau
//' @param sigma A \code{double} containing the residual variance
//' @return A \code{vec} containing the wavelet variance of the ARMA process.
//' @examples
//' arma_to_wv(c(.23,.43), c(.34,.41,.59), 2^(1:9), 3)
//' @seealso \code{\link{ARMAtoMA_cpp}},\code{\link{ARMAacf_cpp}}
// [[Rcpp::export]]
arma::vec arma_to_wv(arma::vec ar, arma::vec ma, arma::vec tau, double sigma) {
  
  arma::vec n = arma::sort(tau/2);
  unsigned int ntau = tau.n_elem;
  double sig2 = (arma::sum(arma::square(ARMAtoMA_cpp(ar,ma,1000)))+1)*sigma;
  
  arma::vec wvar(ntau);
  
  // initial starting term
  arma::vec term4 = ARMAacf_cpp(ar, ma, n(0));
  wvar(0)=( ( ( n(0)*(1.0-term4(term4.n_elem-1))) / square(n(0)))*sig2)/2.0;

  for(unsigned int j = 1; j < ntau; j++){
    arma::vec boh(n(j) - 1);
    for (int i=1; i<= n(j) - 1; i++){
      arma::vec term1=ARMAacf_cpp(ar, ma, (n(j)-i));
      arma::vec term2=ARMAacf_cpp(ar, ma, i);
      arma::vec term3=ARMAacf_cpp(ar, ma, (2*n(j)-i));
      // Account for starting loop at 1 instead of 0.
      boh(i-1)=i*((2.0*term1(term1.n_elem-1))-term2(term2.n_elem-1)-term3(term3.n_elem-1));
    }
    arma::vec term4=ARMAacf_cpp(ar, ma, n(j));
    wvar(j)=((( (n(j)*(1.0-term4(term4.n_elem-1)) ) + arma::sum(boh) ) /square(n(j)))*sig2)/2.0;
  }
  
  return wvar;
}


//' @title Quantisation Noise to WV
//' @description This function compute the WV (haar) of a Quantisation Noise (QN) process
//' @param q2 A \code{double} corresponding to variance of drift
//' @param Tau A \code{vec} containing the scales e.g. 2^tau
//' @return A \code{vec} containing the wavelet variance of the QN.
//' @examples
//' x.sim = 1:1000
//' ntau = floor(log(length(x.sim),2))
//' tau = 2^(1:ntau)
//' wv.theo = qn_to_wv(1, tau)
//' plot(tau, wv.theo, col = "red")
// [[Rcpp::export]]
arma::vec qn_to_wv(double q2, const arma::vec& Tau){
  return 3*q2/(2*arma::square(Tau));
}

//' @title White Noise to WV
//' @description This function compute the WV (haar) of a White Noise process
//' @param sig2 A \code{double} corresponding to variance of WN
//' @param Tau A \code{vec} containing the scales e.g. 2^tau
//' @return A \code{vec} containing the wavelet variance of the white noise.
//' @examples
//' x.sim = cumsum(rnorm(100000))
//' ntau = floor(log(length(x.sim),2))
//' tau = 2^(1:ntau)
//' wv.theo = wn_to_wv(1, tau)
//' plot(tau, wv.theo, col = "red")
// [[Rcpp::export]]
arma::vec wn_to_wv(double sig2, arma::vec Tau){
  return sig2/Tau;
}


//' @title Random Walk to WV
//' @description This function compute the WV (haar) of a Random Walk process
//' @param sig2 A \code{double} corresponding to variance of RW
//' @param Tau A \code{vec} containing the scales e.g. 2^tau
//' @return A \code{vec} containing the wavelet variance of the random walk.
//' @examples
//' x.sim = cumsum(rnorm(100000))
//' ntau = floor(log(length(x.sim),2))
//' tau = 2^(1:ntau)
//' wv.theo = rw_to_wv(1,tau)
//' plot(tau, wv.theo, col = "red")
// [[Rcpp::export]]
arma::vec rw_to_wv(double sig2, const arma::vec& Tau){
  return sig2*((2*arma::square(Tau) + 2)/(24*Tau));
}


//' @title Drift to WV
//' @description This function compute the WV (haar) of a Drift process
//' @param omega A \code{double} corresponding to variance of drift
//' @param Tau A \code{vec} containing the scales e.g. 2^tau
//' @return A \code{vec} containing the wavelet variance of the drift.
//' @examples
//' x.sim = 1:1000
//' ntau = floor(log(length(x.sim),2))
//' tau = 2^(1:ntau)
//' wv.theo = dr_to_wv(1, tau)
//' plot(tau, wv.theo, col = "red")
// [[Rcpp::export]]
arma::vec dr_to_wv(double omega,const arma::vec& Tau){
	return square(omega)*arma::square(Tau)/16;
}

//' @title AR1 process to WV
//' @description This function compute the WV (haar) of an AR(1) process
//' @param phi A \code{double} that is the phi term of the AR(1) process
//' @param sig2 A \code{double} corresponding to variance of AR(1) process
//' @param Tau A \code{vec} containing the scales e.g. 2^tau
//' @return A \code{vec} containing the wavelet variance of the AR(1) process.
//' @examples
//' x.sim = gen_ar1( N = 10000, phi = 0.9, sigma2 = 4 )
//' ntau = floor(log(length(x.sim),2))
//' tau = 2^(1:ntau)
//' wv.theo = ar1_to_wv(phi = 0.9, sig2 = 16, tau)
//' plot(tau, wv.theo, col = "red")
// [[Rcpp::export]]
arma::vec ar1_to_wv(double phi, double sig2, const arma::vec& Tau){
  unsigned int size_tau = Tau.n_elem;
  arma::vec temp_term(size_tau);
  arma::vec temp_term_redux(size_tau);
  for(unsigned int i=0; i< size_tau; i++){
    temp_term(i) = 4*pow(phi,(Tau(i)/2 + 1));
    temp_term_redux(i) = pow(phi,(Tau(i)+1));
  }
	return ((Tau/2 - 3*phi - Tau/2*pow(phi,2) + temp_term - temp_term_redux)/(arma::square(Tau/2)*pow(1-phi,2)*(1-pow(phi,2)))*sig2)/2;
}

//' @title Model Process to WV
//' @description This function computes the summation of all Processes to WV (haar) in a given model
//' @param theta A \code{vec} containing the list of estimated parameters.
//' @param desc A \code{vector<string>} containing a list of descriptors.
//' @param nparams A \code{vec} containing the number of parameters per process described in desc.
//' @param tau A \code{vec} containing the scales e.g. 2^(1:J)
//' @param N An \code{integer} containing the number of elements in the time series.
//' @return A \code{vec} containing the wavelet variance of the AR(1) process.
//' @examples
//' x.sim = gen_ar1( N = 10000, phi = 0.9, sigma2 = 4 )
//' ntau = floor(log(length(x.sim),2))
//' tau = 2^(1:ntau)
//' wv.theo = ar1_to_wv(phi = 0.9, sig2 = 16, tau)
//' plot(tau, wv.theo, col = "red")
// [[Rcpp::export]]
arma::vec theo_wv(const arma::vec& theta, const std::vector<std::string>& desc,
                                const arma::vec& tau, int N){
  
  unsigned int num_desc = desc.size();

  arma::vec wv_theo = arma::zeros<arma::vec>(tau.n_elem);
 
  // Loop Counters
  
  unsigned int i_theta = 0;
  for(unsigned int i = 0; i < num_desc; i++){
    double theta_est = theta(i_theta);

    // ARMA is needed!
    
    // AR 1
    if(desc[i] == "AR1"){
      ++i_theta;
      double sig2 = theta(i_theta);
      
      // Compute theoretical WV
      wv_theo += ar1_to_wv(theta_est,sig2,tau);
    }
    // RW
    else if(desc[i] == "RW"){
      wv_theo += rw_to_wv(theta_est,tau);
    }
    // DR
    else if(desc[i] == "DR"){
      wv_theo += dr_to_wv(theta_est,tau);
    }
    // WN
    else{
      wv_theo += wn_to_wv(theta_est,tau);
    }
    
    // Increase counter
     ++i_theta;
  }

  return wv_theo;
}



/* ------------------------------ End Process to WV Functions --------------------------------- */