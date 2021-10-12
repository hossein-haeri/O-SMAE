function [x,y,x_hat, m_c_hat] = simulate_SMA(sigma_w, sigma_v)

n = 1000;
% create a random walk + white noise signal
x = zeros(n, 1);
for i= 2:n
    x(i) = x(i-1) + normrnd(0, sigma_w);
end

% create a Gaussian white noise
v = normrnd(0,sigma_v,[n,1]);

% combine RW and noise signals
y = x + v;

% create a list of window lengths
taus = (1:100);


avar = AVAR(y,taus);
[~, ind] = min(avar);
m_c_hat = taus(ind);
x_hat = SMAE(y,m_c_hat);

end