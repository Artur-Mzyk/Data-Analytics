data {
  int<lower=0> N; // Number of samples
  real unplanned_stops_times[N]; // Observed heights
  vector[N] weight_counters;
  vector[N] weight_cycles;
  real mu_mu;
  real<lower=0> mu_sig;
  real sig_lbd;
}

parameters {
  real alpha; // Intercept
  real beta_; // Slope
  real gamma_; // Slope
  real<lower=0> sig; // Standard deviation of height
}

transformed parameters {
   vector[N] mu = weight_cycles * gamma_ + weight_counters * beta_ + alpha;
}

model {
    alpha ~ normal(mu_mu, mu_sig);
    beta_ ~ lognormal(0, 1);
    gamma_ ~ lognormal(0, 1);
    sig ~ exponential(sig_lbd);

    // Likelihood
    unplanned_stops_times ~ exponential(normal(mu, sig));
}

generated quantities {
    real unplanned_stops_time[N];

    for (n in 1:N) {
        unplanned_stops_time[n] = exp(normal_rng(mu[n], sig));
    }
}