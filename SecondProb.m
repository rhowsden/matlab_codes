syms x
v = x.^2/2;
vin = inline(char(v));
f = exp(-v);
fin = inline(char(f));

step = 1;
n_smpls = 100;
n_blk = 20;

rej=0;
energies=0;
store=0;
y=0;

for j=1:500;
    y(j+1) = y(j) + step*(2*rand(1)-1);
    p = fin(y(j+1))/fin(y(j));
    if (p<rand(1))
        y(j+1) = y(j);
    end
end

for k=1:n_blk;
    if k==1
        z=y(501);
    else
        z=z(n_smpls+1);
    end
    
    for i=1:n_smpls;
        z(i+1) = z(i)+ step*(2*rand(1)-1);
        p = fin(z(i+1))/fin(z(i));
        if (p<rand(1))
            z(i+1) = z(i);
            rej = rej + 1;
        end
        store(i)= vin(z(i));
    end
    energies(k) = sum(store)/n_smpls;
end
step = step
n_smpls = n_smpls
n_blk = n_blk
Average_Energy = sum(energies)/n_blk
stde=std(energies)/sqrt(n_blk)
Percentage_Rejection = rej/(n_blk*n_smpls)