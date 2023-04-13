data {
  int<lower=0> N; // Number of samples
  real weight[N]; // Weight samples
  real mu_mu;
  real<lower=0> mu_sig;
  real sig_lbd;
}

generated quantities {
  real height[N];
  real alpha = normal_rng(mu_mu, mu_sig);
  real beta_ = normal_rng(0, 1);
  real sig = exponential_rng(sig_lbd);

  for (n in 1:N) {
    height[n] = normal_rng(alpha + beta_ * weight[n], sig);
  }
}