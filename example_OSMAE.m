clear all 
clc
close all

% create a random walk + white noise signal
x = zeros(1000, 1);
for i= 2:1000
    x(i) = x(i-1) + normrnd(0, 0.1);
end

% create a Gaussian white noise
v = normrnd(0,1,[1000,1]);

% combine RW and noise signals
y = x + v;

% create a list of window lengths
taus = (1:100);


avar = AVAR(y,taus);
[~, ind] = min(avar);
m_c_hat = taus(ind);
x_hat = SMAE(y,m_c_hat);

subplot(2,1,1)
    loglog(avar,'Color',[0.2,0.2,0.2])
    xlabel('Window length $m$')
    ylabel('AVAR $\sigma_A^2$')
    grid on
    box on
subplot(2,1,2)
    hold on
    plot(y,'DisplayName','Measurement','Color',[0.2,0.2,0.2])
    plot(x,'LineWidth',2,'DisplayName','Target parameter','Color',[243, 114, 44, 200]./255)
    plot(x_hat,'LineWidth',2,'DisplayName','O-SMAE','Color',[144, 190, 109, 200]./255)
    
    xlabel('Timestep $k$')
    ylabel('Parameter')
    ylim([-5,8])
    box on
    grid on
    legend;
    
    