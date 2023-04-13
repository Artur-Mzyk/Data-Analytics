data {
  int<lower=0> N; // Number of samples
  real weight[N]; // Weight samples
}

generated quantities {
  real height[N];
  real alpha = normal_rng(175, 15);
  real beta_ = normal_rng(0, 10);
  real sigma = exponential_rng(0.07);

  for (n in 1:N) {
    height[n] = normal_rng(alpha + beta_ * weight[n], sigma);
  }
}