syms x
v = x.^2/2;
vin = inline(char(v));
n=10000;
stores=0;
muller=0;

muller = BoxMull(n);

for i=1:n;
    stores(i) = vin(muller(i));
end
Average_Energy = sum(stores)/n
stde=std(stores)/sqrt(n)