clear all
close all
clc

set(groot,'defaulttextinterpreter','latex');
set(groot, 'defaultAxesTickLabelInterpreter','latex');
set(groot, 'defaultLegendInterpreter','latex');
set(groot, 'defaultAxesFontSize',15);

ratio = linspace(0,4,1000);

m = sqrt(3*ratio.^2+0.5);

m_c = zeros(1,numel(m));

for i=1:numel(m)
% m_c = min()

% [~, I] = min(f(floor(m(i)),ratio(i)),f(floor(m(i))+1,ratio(i)));
if f(floor(m(i)),ratio(i)) <= f(floor(m(i))+1,ratio(i))
    m_c(i) = floor(m(i));
%     disp('1')
elseif f(floor(m(i)),ratio(i)) > f(floor(m(i))+1,ratio(i))
    m_c(i) = floor(m(i))+1;
%     disp('2')
end
end



plot(ratio,m_c,'LineWidth',1.5)
grid on
xlabel('Ratio, $\sigma_v/\sigma_w$')
ylabel('Characteristic timescale, $m_c$')

function e = f(m,r)
e = ((2*m^2-3*m+1)/(6*m)) + (1/m)*(r^2); 
end




