function avar = AVAR(y,taus)
n = numel(y);
z = zeros(1,n);
for k=1:n
    z(k) = sum(y(1:k));
end
avar = zeros(1,numel(taus));
for i=1:numel(taus)
   m = taus(i);
   summation = 0;
   for k=1:n-2*m
       summation = summation + (z(k+2*m) - 2*z(k+m) + z(k))^2;
   end
   avar(i) = 1/(2*m^2*(n-2*m)) * summation;
end
end