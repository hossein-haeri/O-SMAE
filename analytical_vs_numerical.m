clear all
clc
close all

num_monte = 500;

sigma_v_list = [1, 2, 4];
sigma_w_list = [1, 1, 1];

avar_case = [];
avar_case_std = [];
avar_analytical_case = [];
avar_analytical_case_std = [];
for c=1:3
    sigma_w = sigma_w_list(c);
    sigma_v = sigma_v_list(c);
    ratio = sigma_v/sigma_w;
    avar_list = [];
    avar_analytical_list = [];
    mse_avar = [];
    mse_optimal = [];
    for monte=1:num_monte
    
        m_c = find_m_c(sigma_w, sigma_v);

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
        avar_analytical = ((2.*(taus.^2)+1)./(6.*taus))*sigma_w^2 + (1./taus) * sigma_v^2;
%         [~, ind] = min(avar);
%         m_c_hat = taus(ind);
%         x_hat_avar = SMAE(y,m_c_hat);
%         x_hat_optimal = SMAE(y,m_c);
%         
%         mse_avar = [mse_avar mean((x-x_hat_avar).^2)];
%         mse_optimal = [mse_optimal mean((x-x_hat_optimal).^2)];
        avar_list = [avar_list; avar];
        avar_analytical_list = [avar_analytical_list; avar_analytical];

    end
    avar_case = [avar_case; mean(avar_list,1)];
    avar_case_std = [avar_case_std; std(avar_list,1)];
    avar_analytical_case = [avar_analytical_case; mean(avar_analytical_list,1)];
    
end
colors = lines(3);
hold all

for c=1:3
plot(avar_case(c,:),...
                'DisplayName','A',...
                'Color', colors(c,:),...
                'LineWidth',1 ...
                );
% y1 = avar_case(c,:) - avar_case_std(c,:);
% y2 = avar_case(c,:) + avar_case_std(c,:);
% x = taus;
% patch([x fliplr(x)], [y1 fliplr(y2)],colors(c,:),'FaceAlpha',.2,'EdgeAlpha',0.0)            
plot(avar_analytical_case(c,:),...
                'DisplayName','A',...
                'Color', colors(c,:),...
                'LineStyle','--',...
                'LineWidth',2);
end
legend( '$\sigma_v/\sigma_w=1$ (numerical)',...
        '$\sigma_v/\sigma_w=1$ (analytical)',...
        '$\sigma_v/\sigma_w=2$ (numerical)',...
        '$\sigma_v/\sigma_w=2$ (analytical)',...
        '$\sigma_v/\sigma_w=4$ (numerical)',...
        '$\sigma_v/\sigma_w=4$ (analytical)'...
        );
    
for c=1:3
y1 = avar_case(c,:) - avar_case_std(c,:);
y2 = avar_case(c,:) + avar_case_std(c,:);
x = taus;
patch([x fliplr(x)], [y1 fliplr(y2)],colors(c,:),'FaceAlpha',.2,'EdgeAlpha',0.0)            
end

set(gca, 'XScale', 'log')
set(gca, 'YScale', 'log')
xlabel('Window length $m$')
ylabel('AVAR $\sigma_A^2$')
grid on
box on

