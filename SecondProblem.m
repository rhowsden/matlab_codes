syms x
v = x.^2/2;
vin = inline(char(v));
f = exp(-v);
fin = inline(char(f));
x=0;

int(exp(-v),-inf,inf);
int(v*f,-inf,inf);


for j=1:500;
    x(j+1) = x(j)+(2*rand(1)-1);
    p = fin(x(j+1))/fin(x(j));
    if (p<rand(1))
        x(j+1) = x(j);
    end
end

y=x(501);

blocktotal=0;
n_smpls=100;
n_blk=20;
for k=1:n_blk;
for i=1:n_smpls;
    y(i+1) = y(i)+(2*rand(1)-1);
    p = fin(y(i+1))/fin(y(i));
    if (p>rand(1))
        y(i+1) = y(i);
    end
    blocktotal = blocktotal + y(i);
end
z(k)=blocktotal/n_smpls;
end

sum_energy=0;
for r=1:n_blk;
    sum_energy=sum_energy+vin(z(r));
end
avg_energy=sum_energy/n_blk