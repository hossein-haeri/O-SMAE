clear all
clc
close all

num_monte = 100;


m_c_hat_case_mean = [];
m_c_hat_case_std = [];
m_c_analytical_case_mean = [];
avar_analytical_case_std = [];
e_case = [];
e_case_std = [];
sigma_w = 1;
sigma_v = 2;
ratio = sigma_v/sigma_w;

n_list = [];

for c=1:12
    n = floor(1.7^(8+c));
    n_list = [n_list, n];
    m_c_hat_list = [];
    m_c_list = [];
    mse_avar = [];
    mse_optimal = [];
    e_list = [];
    
    for monte=1:num_monte
    
        m_c = find_m_c(sigma_w, sigma_v);
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
        taus = (1:50);

        avar = AVAR(y,taus);
        avar_analytical = ((2.*(taus.^2)+1)./(6.*taus))*sigma_w^2 + (1./taus) * sigma_v^2;
%         [~, ind] = min(avar);
%         m_c_hat = taus(ind);
%         x_hat_avar = SMAE(y,m_c_hat);
%         x_hat_optimal = SMAE(y,m_c);   
%         mse_avar = [mse_avar mean((x-x_hat_avar).^2)];
%         mse_optimal = [mse_optimal mean((x-x_hat_optimal).^2)];
        [~,ind] = min(avar);
        m_c_hat = taus(ind);
        [~,ind] = min(avar_analytical);
        m_c = taus(ind);
%         m_c_hat_list = [m_c_hat_list; m_c_hat];
%         m_c_list = [m_c_list; m_c];
        e_list = [e_list, abs(m_c_hat-m_c)];

    end
%     m_c_hat_case_mean = [m_c_hat_case_mean; mean(m_c_hat_list,1)];
%     m_c_hat_case_std = [m_c_hat_case_std; std(m_c_hat_list,1)];
%     m_c_analytical_case_mean = [m_c_analytical_case_mean; mean(m_c_list,1)];
    e_case = [e_case, mean(e_list)];
    e_case_std = [e_case_std, std(e_list)];
end



%%
clc
close all
f = figure;
f.Position = [100 100 580 320];

set(groot,'defaulttextinterpreter','latex');
set(groot, 'defaultAxesTickLabelInterpreter','latex');
set(groot, 'defaultLegendInterpreter','latex');
set(groot, 'defaultAxesFontSize',16);

colors = lines(10);
hold all

plot(n_list, e_case,'Color',colors(1,:), 'LineWidth',1)

y1 = e_case - 0.1*e_case_std;
y2 = e_case + 0.1*e_case_std;
x = n_list;
patch([x fliplr(x)], [y1 fliplr(y2)],colors(1,:),'FaceAlpha',.2,'EdgeAlpha',0.0)



set(gca, 'XScale', 'log')
% set(gca, 'YScale', 'log')
xlabel('Signal length $n$')
ylabel('$|\hat{m}_c-m_c|$')
xlim([n_list(1), n_list(end)])
grid on
box on




