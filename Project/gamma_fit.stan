data {
  int<lower=0> N;                         // Number of observations
  vector<lower=0, upper=1>[N] unplanned_stop_times; // Observed unplanned stop times
  vector<lower=0>[N] rejects;              // Values of the rejects variable
  vector<lower=0>[N] cycle_times;          // Values of the cycle_times variable
  real<lower=0> alpha_shape;
  real<lower=0> alpha_scale;
  real<lower=0> beta_shape;
  real<lower=0> beta_scale;
  real<lower=0> gamma_shape;
  real<lower=0> gamma_scale;
}

parameters {
  real<lower=0> alpha;                     // Shape parameter of gamma distribution
  real<lower=0> beta;                      // Rate parameter of gamma distribution
  real<lower=0> gamma;                      // Rate parameter of gamma distribution
}

model {
  // Priors
  alpha ~ gamma(alpha_shape, alpha_scale);                     // Prior for shape parameter
  beta ~ gamma(beta_shape, beta_scale);                      // Prior for rate parameter
  gamma ~ gamma(gamma_shape, gamma_scale);

  // Likelihood
  for (i in 1:N) {
    unplanned_stop_times[i] ~ gamma(alpha, beta * rejects[i] + gamma * cycle_times[i]);
  }
}

generated quantities {
  vector[N] predicted_stop_times;
  vector[N] log_lik;

  // Generate predicted values
  for (i in 1:N) {
    predicted_stop_times[i] = gamma_rng(alpha, beta * rejects[i] + gamma * cycle_times[i]);
    log_lik[i] = gamma_lpdf(unplanned_stop_times[i] | alpha, beta * rejects[i] + gamma * cycle_times[i]);
  }
}