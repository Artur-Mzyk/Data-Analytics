data {
  int<lower=0> N;                         // Number of observations
  vector<lower=0>[N] rejects;              // Values of the rejects variable
  vector<lower=0>[N] cycle_times;          // Values of the cycle_times variable
  real<lower=0> alpha_shape;
  real<lower=0> alpha_scale;
  real<lower=0> beta_shape;
  real<lower=0> beta_scale;
  real<lower=0> gamma_shape;
  real<lower=0> gamma_scale;
}

generated quantities {
  vector<lower=0, upper=1>[N] predicted_stop_times;
  real<lower=0> alpha = gamma_rng(alpha_shape, alpha_scale);  // Shape
  real<lower=0> beta = gamma_rng(beta_shape, beta_scale);   // Slope
  real<lower=0> gamma = gamma_rng(gamma_shape, gamma_scale);   // Slope
  
  for (i in 1:N) {
    predicted_stop_times[i] = gamma_rng(alpha, beta * rejects[i] + gamma * cycle_times[i]);
  }
}