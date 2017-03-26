
%
% 3D Ising
% ising3(n,m,b,q)
%    n - size of domain.  Either a scalar, in which domain is n x n x n
%                         Or a three-vector [n1 n2 n3]
%    m - number of iterations
%    b - coupling parameter / temperature
%                         b = 0 -> Very high temp / low coupling
%                         b >> 1 -> Very low temp / high coupling
%                         b = 4.5115  critical point
%    q - number of independent runs to concatenate (default q=1)
%

%
% P. Fieguth
% University of Waterloo
% Oct, 2002
%

function s = ising3(n,m,b,q)

n=round(n); m=round(m);
if (nargin < 4), q=1; else, q=round(q); end;
x=n(1);y=n(1);z=n(1); 
if (length(n)>2), x=n(1); y=n(2); z=n(3); end;

s = zeros(x*q,y,z);

t = zeros(x+2,y+2,z+2); for i=2:(x+1), for j=2:(y+1), for k=(2+rem(i+j,2)):2:(z+1), t(i,j,k)=1; end; end; end; e = find(t);
t = zeros(x+2,y+2,z+2); for i=2:(x+1), for j=2:(y+1), for k=(3-rem(i+j,2)):2:(z+1), t(i,j,k)=1; end; end; end; o = find(t);
nr = length(e);
ex = exp(-b*[-6:6]);

for qi=1:q,
t = sign(randn(x+2,y+2,z+2));

for j=1:m,
  el = t(e-1) + t(e+1) + t(e-x-2) + t(e+x+2) + t(e-(x+2)*(y+2)) + t(e+(x+2)*(y+2));

  t(e) = 1;
  eel = ex(7+el);
  t(e(find(rand(1,nr)<(eel./(eel+1./eel))))) = -1;

  t(1,:,:)=t(x+1,:,:); t(x+2,:,:)=t(2,:,:); 
  t(:,1,:)=t(:,y+1,:); t(:,y+2,:)=t(:,2,:);
  t(:,:,1)=t(:,:,z+1); t(:,:,z+2)=t(:,:,2);

  el = t(e-1) + t(e+1) + t(e-x-2) + t(e+x+2) + t(e-(x+2)*(y+2)) + t(e+(x+2)*(y+2));

  eel = ex(7+el);
  t(e(find(rand(1,nr)<(eel./(eel+1./eel))))) = -1;

  t(1,:,:)=t(x+1,:,:); t(x+2,:,:)=t(2,:,:); 
  t(:,1,:)=t(:,y+1,:); t(:,y+2,:)=t(:,2,:);
  t(:,:,1)=t(:,:,z+1); t(:,:,z+2)=t(:,:,2);
end;
s((1:x)+(qi-1)*x,:,:) = t(2:(x+1),2:(y+1),2:(z+1));
end;