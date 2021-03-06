library(cmdstanr)
fp <- file.path("./examples/linear_algebra/stan/correlation_angles_example.stan")
mod <- cmdstan_model(fp, include_paths = "./functions/linear_algebra")

T <- matrix(c(0.8, -0.9, -0.9,
              -0.9, 1.1, 0.3,
              -0.9, 0.4, 0.9), 3, 3)


mod_out <- mod$optimize(
  data = list(N = 3,
              R = T)
)

mod_out <- mod$sample(
  data = list(N = 3,
              R = T),
  chains = 2,
  seed = 23421,
  parallel_chains = 2,
  iter_warmup = 600,
  iter_sampling = 600
)

mod_out$summary("R_hat")
mat <- matrix(mod_out$summary("R_hat")$mean, 3, 3)
mat
chol(mat)
