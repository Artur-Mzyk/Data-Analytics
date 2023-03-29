data {
    int<lower=1> N; // Number of trials
    int alpha_; // Alpha parameter for beta distribution
    int beta_; // Beta parameter for beta distribution
    int<lower=0, upper=N> y; // Number of successes
}

parameters {
    real<lower=0, upper=1> p; // Probabiliy of allergic reaction (a priori)
}

model {
    p ~ beta(alpha_, beta_); // Beta distribution as prior distribution
    y ~ binomial(N, p);
}

generated quantities {
  int<lower=0, upper=N> y_pred = binomial_rng(N, p);
}