function mean_pll = CalculateRBMPll(V, W, b, c)
% CALCULATE_RBM_PLL Calculates the average Pseudo-Log-Likelihood (PLL)
%
% Inputs:
%   V      - Test data matrix (M x Nv), M is number of samples, Nv is visible dimension.
%   W           - Weight matrix (Nv x Nh), Nv is visible, Nh is hidden dimension.
%   b           - Visible bias vector (Nv x 1).
%   c           - Hidden bias vector (Nh x 1).
%   num_samples - Number of visible units.
%                 (e.g., 100 or Nv for full calculation).
%
% Output:
%   mean_pll    - Average Pseudo-Log-Likelihood per data point.

% Ensure inputs are in the correct format (double for precision)
V = double(V);
W = double(W);
b = double(b);
c = double(c);

[M, Nv] = size(V); % M samples, Nv visible units
num_samples = Nv;
sum_log_cond_prob = zeros(M, 1);

% 1. Calculate the Free Energy for all original test samples F(v)
% This is the common part for the conditional probability calculation.
F_v_original = rbm_free_energy(V, W, b, c); % Size M x 1

% 2. Main loop: Iterate through the number of sampled pixels
for k = 1:num_samples
    V_flip = V;
    % Flip the m-th sample's idx-th pixel
    V_flip(:, k) = - V_flip(:, k);


    % 4. Calculate the Free Energy for the flipped samples F(v_flip)
    F_v_flip = rbm_free_energy(V_flip, W, b, c); % Size M x 1


    % Delta_F = F(v) - F(v_flip)
    Delta_F = F_v_flip - F_v_original;
    q = 1./(1 + exp(-Delta_F));
    log_cond_prob = log10(q) ;
    % Add the contribution to the total
    sum_log_cond_prob = sum_log_cond_prob + log_cond_prob;
end


% PLL for each sample:
pll_per_sample = sum_log_cond_prob;

mean_pll = mean(pll_per_sample)*196/Nv;
end


function F_v = rbm_free_energy(V, W, b, c)
% RBM_FREE_ENERGY Calculates the Free Energy F(v) for RBM samples.
%
% Inputs:
%   V - Data matrix (M x Nv)
%   W - Weight matrix (Nv x Nh)
%   b - Visible bias vector (Nv x 1)
%   c - Hidden bias vector (Nh x 1)
%
% Output:
%   F_v - Free Energy vector (M x 1)

    vbias_term = V * b;
    
    % Part 2: Hidden layer input (M x Nh)
    wx_b = V * W + c'; % c' is transposed to match the row dimensions of W 
    hidden_term = sum(log((exp(-wx_b) + exp(wx_b))), 2); % Sum across the hidden dimension (dimension 2)   
    % Final Free Energy
    F_v = - vbias_term - hidden_term; % Result is M x 1
end