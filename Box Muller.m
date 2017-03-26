function x=boxmuller(n);

x=zeros(1,n);

len=ceil(n/2);

for i=1:len
u1=rand(1,1);
u2=rand(1,1);
x(i)=sqrt(-2*log(u1))*cos(2*pi*u2);
if (i+len<=n)
x(i+len)=sqrt(-2*log(u1))*sin(2*pi*u2);
end;
end;