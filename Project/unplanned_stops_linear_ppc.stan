data {
  real alpha_; // Weight samples - counters
  real beta_; // Weight samples - cycle times
}

generated quantities {
  real alpha = exponential_rng(alpha_);
  real beta = exponential_rng(beta_);

  real unplanned_stops_time = exponential_rng(beta_);
}