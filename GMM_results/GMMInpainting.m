load('corruptedImg.mat');
load('GMModels.mat')
load('mask.mat')
load('originalImg.mat')
y = corruptedImg(:);
m = mask(:); 
restoredImg_gmm_64 = zeros(400,10);
y_restored = gmm_inpaint_vector(y, m, GMModels{10});
hamin_gmm = zeros(1,1);
for k = 1:10
    restoredImg_gmm_64(:,k) = 2*(y_restored(:,k) > rand(400,1))-1;
    hamin_gmm(1,k) = sum(sum(reshape(restoredImg_gmm_64(:,k), [20, 20])~=2*originalImg-1));
end

% 
figure('Name', 'MNIST GMM Inpainting', 'Color', 'w');

subplot(1, 4, 1);
imshow(reshape(restoredImg_gmm_64(:,1), [20, 20])); 
title('k=1');

subplot(1, 4, 2);
imshow(reshape(restoredImg_gmm_64(:,3), [20, 20])); 
title('k=3');

subplot(1, 4, 3);
imshow(reshape(restoredImg_gmm_64(:,6), [20, 20]));
title('k=6');

subplot(1, 4, 4);
imshow(reshape(restoredImg_gmm_64(:,10), [20, 20]));
title('k=10');



function x_hat = gmm_inpaint_vector(y, mask, gmm)
% y:    D x 1 
% mask: D x 1 (1=Known, 0=Missing)
% gmm:  gmdistribution 

idx_k = find(mask);       % Known indices
idx_u = find(~mask);      % Unknown indices

x_k = y(idx_k);         

K = gmm.NumComponents;
weights = zeros(K, 1);    %  P(k | x_k)
preds_u = zeros(length(idx_u), K); % 
log_liks = zeros(K, 1);

for k = 1:K
    mu = gmm.mu(k, :)';
    Sigma = gmm.Sigma(:, :, k);

    mu_k = mu(idx_k);
    mu_u = mu(idx_u);

    Sigma_kk = Sigma(idx_k, idx_k);
    Sigma_uk = Sigma(idx_u, idx_k);

    % 1.  log N(x_k | mu_k, Sigma_kk)
    try
        
        L = log_mvnpdf_custom(x_k, mu_k, Sigma_kk);
        log_liks(k) = log(gmm.ComponentProportion(k)) + L;
    catch
        log_liks(k) = -inf;
    end

  
    %  mu_u + Sigma_uk * inv(Sigma_kk) * (x_k - mu_k)
    preds_u(:, k) = mu_u + Sigma_uk * (Sigma_kk \ (x_k - mu_k));
end


max_ll = max(log_liks);
if isinf(max_ll)
    posterior = ones(K, 1) / K; 
else
    weights = exp(log_liks - max_ll);
    posterior = weights / sum(weights);
end


%x_hat_u = preds_u * posterior;
for i = 1:K
    x_hat_u = preds_u(:,1:i) * posterior(1:i);
    x_hat(:,i) = y;
    x_hat(idx_u,i) = x_hat_u;
end


end

function logp = log_mvnpdf_custom(x, mu, Sigma)

d = length(x);
try
    R = chol(Sigma);
    logDetSigma = 2 * sum(log(diag(R)));
    x_centered = x - mu;
    quadForm = sum((x_centered' / R).^2);
    logp = -0.5 * (d * log(2*pi) + logDetSigma + quadForm);
catch
    logp = -inf;
end
end
