data {
    int<lower=0> N;
    vector[N] n_i;
    real alpha_mu;
    real<lower=0> alpha_sig;
    real theta_mu;
    real<lower=0> theta_sig;
}

generated quantities {
    real alpha[N];

    for (i in 1:N) {
        alpha[i] = normal_rng(alpha_mu, alpha_sig);
    }

    real theta = normal_rng(theta_mu, theta_sig);

    real lambda[N];

    for (i in 1:N) {
        lambda[i] = exp(alpha[i] + theta * n_i[i]);
    }
    
    int<lower=0> y[N];

    for (i in 1:N) {
        y[i] = poisson_rng(lambda[i]);
    }
}