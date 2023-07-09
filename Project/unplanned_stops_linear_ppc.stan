data {
  real beta_;
  real cycle_time_;  // Cycle time values
}

generated quantities {
  real beta = exponential_rng(beta_);
  real cycle_time = exponential_rng(cycle_time_);

  real unplanned_stops_time = exponential(beta*cycle_time);
}