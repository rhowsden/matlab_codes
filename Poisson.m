function [Init] = Poisson(dim, chargesize,outV,ite,method)
block=dim/chargesize;
x=chargesize*floor(block/2)+1;
y=x+chargesize-1;
rho=(1/(dim-1))^2*(1/(chargesize)^2);
Init = outV*ones(dim);
charge = zeros(dim);
charge(x:y,x:y)=rho;

if method==1
    for i=1:ite;
        z=Init;
        Init = (circshift(z,1)+circshift(z,-1)+circshift(z,[0,1])+circshift(z,[0,-1])+charge)/4;
        Init(1,:)=outV;
        Init(:,1)=outV;
        Init(dim,:)=outV;
        Init(:,dim)=outV;
    end
    
elseif method==2
    for i=1:ite;
        z=Init;
        for j=2:dim-1;
            for k=2:dim-1;
                Init(j,k)=(z(j+1,k)+z(j-1,k)+z(j,k+1)+z(j,k-1)+charge(j,k))/4;
            end
        end
    end
end 