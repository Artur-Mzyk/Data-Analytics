data {
    real mu_mu;
    real<lower=0> mu_sig;
    real sig_lbd;
}

generated quantities {
  real mu = normal_rng(mu_mu, mu_sig);
  real sig = exponential_rng(sig_lbd);
  real unplanned_stops_time = normal_rng(mu, sig);
}