data {
  int<lower=0> N;  // Number of observations
  vector<lower=0>[N] cycle_times;  // Cycle time values
}

generated quantities {
  vector[N] predicted_stop_times;
  real alpha = exponential_rng(1);
  real beta = exponential_rng(1);

  for (i in 1:N) {
    predicted_stop_times[i] = exponential_rng(alpha + beta * cycle_times[i]);
  }
}