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

num_workers = 4
batch_size = 1
valid_size = 0.2
ens = 10
use_BayNN = True
test_ens = 10
use_clt = True
clt_num = 10

# for mnist
# att_type = ["noise", "gaussian", "fgsm", "pgd", "bim"]
# eps = [0.025, 0.05, 0.075, 0.1, 0.125, 0.15, 0.175, 0.2, 0.225, 0.25, 0.275, 0.3]

# for PCAM
att_type = ["pgd"]
eps = [1/255, 2/255, 4/255, 8/255, 16/255]
nb_iter = 10
