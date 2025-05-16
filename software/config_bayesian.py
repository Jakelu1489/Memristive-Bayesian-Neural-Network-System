layer_type = "lrt"
activation_type = "relu"
priors = {
    "prior_mu": 0,
    "prior_sigma": 0.1,
    "posterior_mu_initial": (0, 0.1),
    "posterior_rho_initial": (-5, 0.1)
}

n_epochs = 100
lr_start = 0.001
num_workers = 4
valid_size = 0.2
batch_size = 256
train_ens = 10
valid_ens = 10
test_ens = 10
beta_type = 0.1 
use_clt = True
clt_num = 10
