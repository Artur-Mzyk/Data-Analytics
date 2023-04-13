data {
  int<lower=0> N; // Number of samples
  real heights[N]; // Observed heights
  real mu_mu;
  real<lower=0> mu_sig;
  real sig_lbd;
}

parameters {
  real mu; // Mean height
  real<lower=0> sig; // Standard deviation of height
}

model {
  mu ~ normal(mu_mu, mu_sig); // Prior for mean height
  sig ~ exponential(sig_lbd); // Prior for standard deviation of height
  
  // Likelihood
  heights ~ normal(mu, sig); // Normal likelihood with mean height and standard deviation
}

generated quantities {
  real height = normal_rng(mu, sig); // Posterior sample of height
}