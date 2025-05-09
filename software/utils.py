import torch
import torch.nn.functional as F
import numpy as np

cifar10_calsses = ["ariplane", "automobile", "bird", "cat", "deer", "dog", "frog", "horse", "ship", "truck"]


def logmeanexp(x, dim=None, keepdim=False):
    if dim is None:
        x, dim = x.view(-1), 0

    x_max, _ = torch.max(x, dim, keepdim=True)
    x = x_max + torch.log(torch.mean(torch.exp(x - x_max), dim, keepdim=True))

    return x if keepdim else x.squeeze(dim)


def adjust_learning_rate(optimizer, lr):
    """Sets the learning rate to the initial LR decayed by 10 evergy 30 epoches"""
    for param_group in optimizer.param_groups:
        param_group["lr"] = lr


def save_array_to_file(numpy_array, filename):
    file = open(filename, "a")
    shape = " ".join(map(str, numpy_array.shape))
    np.savetxt(file, numpy_array.flatten(), newline=" ", fmt="%.3f")
    file.write("\n")
    file.close()


def get_uncertainty_per_image(model, input_image, T=15, normalized=False):
    input_image = input_image.unsqueeze(0)
    input_images = input_image.repeat(T, 1, 1, 1)

    net_out, _ = model(input_images)
    pred = torch.mean(net_out, dim=0).detach().cpu().numpy()
    if normalized:
        prediction = F.softplus(net_out)
        p_hat = prediction / torch.sum(prediction, dim=1).unsqueeze(1)
    else:
        p_hat = F.softmax(net_out, dim=1)
    p_hat = p_hat.detach().cpu().numpy()
    p_bar = np.mean(p_hat, axis=0)

    temp = p_hat - np.expand_dims(p_bar, 0)
    epistemic = np.dot(temp.T, temp) / T
    epistemic = np.diag(epistemic)

    aleatoric = np.diag(p_bar) - (np.dot(p_hat.T, p_hat) / T)
    aleatoric = np.diag(aleatoric)

    return pred, epistemic, aleatoric


def get_uncertainty_per_batch(model, batch, T=15, normalized=False):
    batch_predictions = []
    net_outs = []
    batches = batch.unsqueeze(0).repeat(T, 1, 1, 1)

    preds = []
    epistemics = []
    aleatorics = []

    for i in range(T):
        net_out, _ = model(batches[i].unsqueeze(1))
        net_outs.append(net_out)
        if normalized:
            prediction = F.softplus(net_out)
            prediction = prediction / torch.sum(prediction, dim=1).unsqueeze(1)
        else:
            prediction = F.softmax(net_out, dim=1)

        batch_predictions.append(prediction)

    for sample in range(batch.shape[0]):
        pred = torch.cat([a_batch[sample].unsqueeze(0) for a_batch in net_outs], dim=0)
        pred = torch.mean(pred, dim=0)
        preds.append(pred)

        p_hat = torch.cat([a_batch[sample].unsqueeze(0) for a_batch in batch_predictions], dim=0).detach().cpu().numpy()
        p_bar = np.mean(p_hat, axis=0)

        temp = p_hat - np.expand_dims(p_bar, 0)
        epistemic = np.dot(temp.T, temp) / T
        epistemic = np.diag(epistemic)
        epistemics.append(epistemic)

        aleatoric = np.diag(p_bar) - (np.dot(p_hat.T, p_hat) / T)
        aleatoric = np.diag(aleatoric)
        aleatorics.append(aleatoric)

    epistemic = np.vstack(epistemics)
    aleatoric = np.vstack(aleatorics)
    preds = torch.cat([i.unsqueeze(0) for i in preds]).cpu().detach().numpy()

    return preds, epistemic, aleatoric
