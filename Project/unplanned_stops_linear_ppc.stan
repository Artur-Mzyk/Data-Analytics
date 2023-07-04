data {
  int<lower=0> N; // Number of samples
  real weight_counters[N]; // Weight samples - counters
  real weight_cycles[N]; // Weight samples - cycle times
  real mu_mu;
  real<lower=0> mu_sig;
  real sig_lbd;
}

generated quantities {
  real unplanned_stops_time[N];
  real alpha = normal_rng(mu_mu, mu_sig);
  real beta_ = lognormal_rng(0, 1);
  real gamma_ = lognormal_rng(0, 1);
  real sig = exponential_rng(sig_lbd);

  for (n in 1:N) {
    unplanned_stops_time[n] = exp(normal_rng(alpha + beta_ * weight_counters[n] + gamma_ * weight_cycles[n], sig));
  }
}