data {
    int<lower=0> N;
    vector[N] weight;
    real height[N];
}

parameters {
    real alpha;
    real beta;
    real sigma;
}

transformed parameters {
   vector[N] mu = weight * beta + alpha;
}

model {
    alpha ~ norma(175, 15);
    beta_ ~ normal(lognormal(0, 1));
    sig ~ exponential(0.07);
    height ~ normal(mu, sig);
}

generated quantities {
    real height_sample[N];

    for (n in 1:N) {
        height_sample[i] = normal_rng(mu[i], sig);
    }
}