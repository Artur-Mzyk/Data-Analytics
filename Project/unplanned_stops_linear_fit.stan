data {
  int<lower=0> N;  // Number of observations
  vector<lower=0>[N] unplanned_stops_times;  // Known unplanned stop time values
  vector<lower=0>[N] cycle_times;  // Cycle time values
}

parameters {
  real<lower=0> alpha;  // Intercept
  real<lower=0> beta;   // Slope
}

model {
  // Priors
  alpha ~ exponential(1);  // Exponential prior for intercept
  beta ~ exponential(1);   // Exponential prior for slope
  
  // Likelihood
  for (i in 1:N) {
    unplanned_stops_times[i] ~ exponential(alpha + beta * cycle_times[i]);
  }
}

generated quantities {
  vector[N] predicted_stop_times;
  
  for (i in 1:N) {
    predicted_stop_times[i] = exponential_rng(alpha + beta * cycle_times[i]);
  }
}
