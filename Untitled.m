dim = 4;
ite = 50;
tempsteps = 75;
T = linspace(2,4.5,tempsteps);
run = 120000;
Eavg = zeros(1,run);
magnet = zeros(1,run);
EnergTemp = zeros(1,tempsteps);
MagnetTemp = zeros(1,tempsteps);
CapacTemp = zeros(1,tempsteps);

for b = 1:tempsteps

for i = 1:run
 x = sign(rand(dim));
for j = 1:ite
    for k = 1:dim
        for l = 1:dim

        keep = x(k,l);
        flip = -x(k,l);            
            
        down = mod(k,dim) + 1;
        right = mod(l,dim) + 1;
        up = mod(k+dim-2,dim) + 1;
        left = mod(l+dim-2,dim) + 1;

	    %total_spin = x(k,right) + x(down,l) + x(k,left) + x(up,l);
        total_spin = x(k,right) + x(down,l) + x(k,left) + x(up,l) + x(up,right) + x(down,right);
        
        kenergy=-keep*total_spin;
        fenergy=-flip*total_spin;
        change = (fenergy - kenergy)/T(b);
        
        if (change <= 0) || (exp(-change) > rand) 
            x(k,l) = flip;
        end

        end
    end        
end

%shift = circshift(x,1)+circshift(x,-1)+circshift(x,[0,1])+circshift(x,[0,-1]);
shift = circshift(x,1)+circshift(x,-1)+circshift(x,[0,1])+circshift(x,[0,-1])+circshift(x,[1,-1])+circshift(x,[-1,-1]);
Energy = -shift.*x/2;
magnet(i) = sum(sum(x))/(dim)^2;
Eavg(i) = sum(sum(Energy))/(dim)^2;

end
MagnetTemp(b) = sum(magnet)/run;
EnergTemp(b) = sum(Eavg)/run
end

for r=1:(tempsteps-1)
    CapacTemp(1)=0;
    CapacTemp(r+1)=EnergTemp(r+1)-EnergTemp(r)
end
