data {
    int<lower=1> N; // Number of trials
    int alpha_; // Alpha parameter for beta distribution
    int beta_; // Beta parameter for beta distribution
}

generated quantities {
  int<lower=0, upper=N> y; // Number of successes
  real<lower=0, upper=1> p; // Probabiliy of allergic reaction (a priori)
  p = beta_rng(alpha_, beta_); // Beta distribution as prior distribution
  y = binomial_rng(N, p);
}