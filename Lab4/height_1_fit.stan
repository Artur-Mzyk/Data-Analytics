data {
  int<lower=0> N; // Number of samples
  real heights[N]; // Observed heights
}

parameters {
  real mu; // Mean height
  real<lower=0> sig; // Standard deviation of height
}

model {
  mu ~ normal(175, 15); // Prior for mean height
  sig ~ exponential(0.07); // Prior for standard deviation of height
  
  // Likelihood
  heights ~ normal(mu, sig); // Normal likelihood with mean height and standard deviation
}

generated quantities {
  real height_sample; // Posterior sample of height
  height_sample = normal_rng(mu, sig); // Sample a posterior sample of height
}