n = 8;
m = 100;
q = 1;
tempsteps = 100;
T = linspace(1,5,tempsteps);
run = 1000;
Eavg = zeros(1,run);
magnet = zeros(1,run);
EnergTemp = zeros(1,tempsteps);
MagnetTemp = zeros(1,tempsteps);
CapacTemp = zeros(1,tempsteps);

for b = 1:tempsteps

for i=1:run

x = ising2(n,m,T(b),q);

shift = circshift(x,1)+circshift(x,-1)+circshift(x,[0,1])+circshift(x,[0,-1]);
%shift = circshift(x,1)+circshift(x,-1)+circshift(x,[0,1])+circshift(x,[0,-1])+circshift(x,[1,-1])+circshift(x,[-1,-1]);
Energy = -shift.*x/2;
magnet(i) = sum(sum(x))/n^2;
Eavg(i) = sum(sum(Energy))/n^2;

end
MagnetTemp(b) = sum(magnet)/run
EnergTemp(b) = sum(Eavg)/run
end

for r=1:(tempsteps-1)
    CapacTemp(1)=0;
    CapacTemp(r+1)=EnergTemp(r+1)-EnergTemp(r)
end