function m_c = find_m_c(sigma_w,sigma_v)
ratio = sigma_v/sigma_w;
m = sqrt(3*ratio.^2+0.5);
if f(floor(m),ratio) <= f(floor(m)+1,ratio)
    m_c = floor(m);
elseif f(floor(m),ratio) > f(floor(m)+1,ratio)
    m_c = floor(m)+1;
end
end
function e = f(m,r)

e = ((2*m^2-3*m+1)/(6*m)) + (1/m)*(r^2); 


end