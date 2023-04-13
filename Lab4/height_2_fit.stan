data {
  int<lower=0> N; // Number of samples
  real heights[N]; // Observed heights
  vector[N] weight;
  real mu_mu;
  real<lower=0> mu_sig;
  real sig_lbd;
}

parameters {
  real alpha; // Intercept
  real beta_; // Slope
  real<lower=0> sig; // Standard deviation of height
}

transformed parameters {
   vector[N] mu = weight * beta_ + alpha;
}

model {
    alpha ~ normal(mu_mu, mu_sig);
    beta_ ~ lognormal(0, 1);
    sig ~ exponential(sig_lbd);

    // Likelihood
    heights ~ normal(mu, sig);
}

generated quantities {
    real height[N];

    for (n in 1:N) {
        height[n] = normal_rng(mu[n], sig);
    }
}