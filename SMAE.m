function x_hat = SMAE(y,m)
    n = numel(y);
    x_hat = zeros(1,n);
    for k=1:n
        x_hat(k) = mean(y(max(1,k-m+1):k));
    end
end