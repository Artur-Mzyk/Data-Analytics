data {
    int<lower=0> N;
    vector[N] n_i;
    real alpha_mu;
    real<lower=0> alpha_sig;
    real theta_mu;
    real<lower=0> theta_sig;
}

generated quantities {
    real alpha = normal_rng(alpha_mu, alpha_sig);
    real theta = normal_rng(theta_mu, theta_sig);
    vector[N] lambda = exp(alpha + theta * n_i);
    int<lower=0> y[N];

    for (i in 1:N) {
        y[i] = poisson_rng(lambda[i]);
    }
}