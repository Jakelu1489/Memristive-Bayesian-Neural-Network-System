import torch
import torch.nn.functional as F

INF = float("inf")


def carlini_wagner_l2(
        model_fn,
        x,
        n_classes,
        num_ens,
        y=None,
        targeted=False,
        lr=5e-3,
        confidence=0,
        clip_min=0,
        clip_max=1,
        initial_const=1e-2,
        binary_search_steps=3, # default: 5
        max_iterations=10  # default: 1000
):
    def compare(pred, label, is_logits=False):
        if is_logits:
            pred_copy = pred.clone().detach()
            pred_copy[label] += -confidence if targeted else confidence
            pred = torch.argmax(pred_copy)
        return pred == label if targeted else pred != label

    """if y is None:
        pred = model_fn(x)
        y = torch.argmax(pred, 1)"""

    lower_bound = [0.0] * len(x)
    upper_bound = [1e10] * len(x)
    const = x.new_ones(len(x), 1) * initial_const

    o_bestl2 = [INF] * len(x)
    o_bestscore = [-1.0] * len(x)
    x = torch.clamp(x, clip_min, clip_max)
    ox = x.clone().detach()
    o_bestattack = x.clone().detach()

    x = (x - clip_min) / (clip_max - clip_min)
    x = torch.clamp(x, 0, 1)
    x = x * 2 - 1
    x = torch.arctanh(x * 0.999999)

    modifier = torch.zeros_like(x, requires_grad=True)
    y_onehot = torch.nn.functional.one_hot(y, n_classes).to(torch.float)

    f_fn = lambda real, other, targeted: torch.max(((other - real) if targeted else (real - other)) + confidence,
                                                   torch.tensor(0.0).to(real.device))
    l2dist_fn = lambda x, y: torch.pow(x - y, 2).sum(list(range(len(x.size())))[1:])
    optimizer = torch.optim.Adam([modifier], lr=lr)

    for outer_step in range(binary_search_steps):
        bestl2 = [INF] * len(x)
        bestscore = [-1.0] * len(x)

        for i in range(max_iterations):
            new_x = (torch.tanh(modifier + x) + 1) / 2
            new_x = new_x * (clip_max - clip_min) + clip_min
            outputs = torch.zeros(new_x.shape[0], n_classes, num_ens).to(torch.device(x.device))
            for j in range(num_ens):
                net_out, _ = model_fn(new_x)
                outputs[:, :, j] = net_out   # watch out here, it may be wrong! we want the logit, not softmax output
            logits = torch.mean(outputs, dim=2)
            # net_out = model_fn(new_x)  # for non_Bayesian neural network
            # logits = net_out

            real = torch.sum(y_onehot * logits, 1)
            other, _ = torch.max((1 - y_onehot) * logits - y_onehot * 1e4, 1)

            optimizer.zero_grad()
            f = f_fn(real, other, targeted)
            l2 = l2dist_fn(new_x, ox)
            loss = (const * f + l2).sum()
            loss.backward()
            optimizer.step()

            for n, (l2_n, logits_n, new_x_n) in enumerate(zip(l2, logits, new_x)):
                y_n = y[n]
                succeeded = compare(logits_n, y_n, is_logits=True)
                if l2_n < o_bestl2[n] and succeeded:
                    pred_n = torch.argmax(logits_n)
                    o_bestl2[n] = l2_n
                    o_bestscore[n] = pred_n
                    o_bestattack[n] = new_x_n
                    bestl2[n] = l2_n
                    bestscore[n] = pred_n
                elif l2_n < bestl2[n] and succeeded:
                    bestl2[n] = l2_n
                    bestscore[n] = torch.argmax(logits_n)

        for n in range(len(x)):
            y_n = y[n]

            if compare(bestscore[n], y_n) and bestscore[n] != -1:
                upper_bound[n] = min(upper_bound[n], const[n])
                if upper_bound[n] < 1e9:
                    const[n] = (lower_bound[n] + upper_bound[n]) / 2
            else:
                lower_bound[n] = max(lower_bound[n], const[n])
                if upper_bound[n] < 1e9:
                    const[n] = (lower_bound[n] + upper_bound[n]) / 2
                else:
                    const[n] *= 10
    return o_bestattack.detach()


if __name__ == "__main__":
    x = torch.clamp(torch.randn(5, 10), 0, 1)
    y = torch.randint(0, 9, (5,))
    model_fn = lambda x: x

    new_x = carlini_wagner_l2(model_fn, x, 10, targeted=True, y=y)
    new_pred = model_fn(new_x)
    new_pred = torch.argmax(new_pred, 1)

    new_x = carlini_wagner_l2(model_fn, x, 10, targeted=False, y=y)
    new_pred = model_fn(new_x)
    new_pred = torch.argmax(new_pred, 1)

    print("finish")
