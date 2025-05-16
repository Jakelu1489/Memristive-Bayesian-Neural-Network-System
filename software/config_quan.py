layer_type = "lrt"
activation_type = "relu"
priors = {
    "prior_mu": 0,
    "prior_sigma": 0.1,
    "posterior_mu_initial": (0, 0.1),
    "posterior_rho_initial": (-5, 0.1)
}

quan_scheduler = {
    "act": {"mode": "lsq",
            "bit": 3,
            "per_channel": False,
            "symmetric": False,
            "all_positive": True},
    "mu": {"mode": "lsq",
           "bit": 4,
           "per_channel": False,
           "symmetric": True,
           "all_positive": False},
    "sigma": {"mode": "lsq",
              "bit": 3,
              "per_channel": False,
              "symmetric": False,
              "all_positive": True},
    "excepts": {
        "conv1": {
            "act": {"mode": None,
                    "bit": None,
                    "per_channel": False,
                    "symmetric": False,
                    "all_positive": True},
            "mu": {"mode": "lsq",
                   "bit": 4,
                   "per_channel": False,
                   "symmetric": True,
                   "all_positive": False},
            "sigma": {"mode": "lsq",
                      "bit": 3,
                      "per_channel": False,
                      "symmetric": False,
                      "all_positive": True}
        }
    }
}


n_epochs = 100
lr_start = 0.0001
num_workers = 4
valid_size = 0.2
batch_size = 100
train_ens = 10
valid_ens = 10
test_ens = 10
beta_type = 0.1
use_clt = True
clt_num = 10
