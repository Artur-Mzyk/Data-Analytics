data {
    int<lower=0> N;
    vector[N] n_i;
    int<lower=0> y[N];
    real alpha_mu;
    real<lower=0> alpha_sig;
    real theta_mu;
    real<lower=0> theta_sig;
}

parameters {
    vector[N] alpha;
    real theta;
}

transformed parameters {
   vector[N] lambda = exp(alpha + theta * n_i);
}

model {
    alpha ~ normal(alpha_mu, alpha_sig); 
    theta ~ normal(theta_mu, theta_sig);

    for (i in 1:N) {
        y[i] ~ poisson(lambda[i]);
    }
}

generated quantities {
    int<lower=0> y_pred[N];

    for (i in 1:N) {
        y_pred[i] = poisson_rng(lambda[i]);
    }
}