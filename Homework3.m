dim = 8;
ite = 50;
tempsteps = 100;
T = linspace(1,5,tempsteps);
run = 100;
Eavg = zeros(1,run);
magnet = zeros(1,run);
EnergTemp = zeros(1,tempsteps);
MagnetTemp = zeros(1,tempsteps);
CapacTemp = zeros(1,tempsteps);

for b = 1:tempsteps

for i = 1:run
x = sign(rand(dim));
for j = 1:ite,
    if mod(dim,2) == 0
        odd = repmat(eye(2),dim/2,dim/2);
        even = ~odd;
    else
        odd = repmat(eye(2),(dim+1)/2,(dim+1)/2);
        odd(:,dim+1) = []; odd(dim+1,:) = [];
        even = ~odd;
    end
    
    shift = circshift(x,1)+circshift(x,-1)+circshift(x,[0,1])+circshift(x,[0,-1]);
    
    old = -shift.*odd.*x;
    new = shift.*odd.*x;
    change = (new-old)/T(b);
    
    flipo = -odd.*sign(exp(-change)-rand(dim));
    store1 = flipo.*x;
    store2 = ~store1.*x;
    x = store1 + store2;
    
    shift = circshift(x,1)+circshift(x,-1)+circshift(x,[0,1])+circshift(x,[0,-1]);
    
    old = -shift.*even.*x;
    new = shift.*even.*x;
    change = (new-old)/T(b);

    flipe = -even.*sign(exp(-change)-rand(dim));
    store1 = flipe.*x;
    store2 = ~store1.*x;
    x = store1 + store2; 
end

shift = circshift(x,1)+circshift(x,-1)+circshift(x,[0,1])+circshift(x,[0,-1]);
Energy = -shift.*x/2
magnet(i) = sum(sum(x))/(dim)^2;
Eavg(i) = sum(sum(Energy))/;

end
MagnetTemp(b) = sum(magnet)/run;
EnergTemp(b) = sum(Eavg)/run;
end

