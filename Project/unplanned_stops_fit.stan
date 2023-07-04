data {
  int<lower=0> N; // Number of samples
  real unplanned_stops_times[N]; // Observed unplanned stops times
  real mu_mu;
  real<lower=0> mu_sig;
  real sig_lbd;
}

parameters {
  real mu; // Mean unplanned stops time
  real<lower=0> sig; // Standard deviation of unplanned stops time
}

model {
  mu ~ normal(mu_mu, mu_sig); // Prior for mean unplanned stop time
  sig ~ exponential(sig_lbd); // Prior for standard deviation of unplanned stop time
  
  // Likelihood
  unplanned_stops_times ~ normal(mu, sig); // Normal likelihood with mean unplanned stop time and standard deviation
}

generated quantities {
  real unplanned_stops_time = normal_rng(mu, sig); // Posterior sample of unplanned stop time
}