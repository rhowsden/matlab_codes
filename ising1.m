%
% 1D Ising
% ising1(n,m,b,p)
%    n - length of domain, a positive integer
%    m - number of iterations, a positive integer
%    b - coupling parameter / temperature, a positive scalar
%                         b = 0 -> Very high temp / low coupling
%                         b > 1 -> Very low temp / high coupling
%    p - the number of independent runs to concatenate (default p=1)
%

%
% P. Fieguth
% University of Waterloo
% Oct, 2002
%

function s = ising1(n,m,j,p)

n=round(n); m=round(m); p=round(p);
if (nargin<4), p=1; else, p=round(p); end;
s = zeros(p,n);

e = 2:2:n;
o = 3:2:(n+1);
ex = exp(-j*[-2:2]);

for j=1:p,
  t = sign(randn(1,n+2));
  for i=1:m,
    el = (t(e-1) + t(e+1));
    t(e) = 1;
    eel = ex(3+el);
    t(e(find(rand(1,n/2)<(eel./(eel+1./eel))))) = -1;
    t(n+2) = t(2);

    el = (t(o-1) + t(o+1));
    t(o) = 1;
    eel = ex(3+el);
    t(o(find(rand(1,n/2)<(eel./(eel+1./eel))))) = -1;
    t(1) = t(n+1); 
  end;
  s(j,:) = t(2:(n+1));
end;