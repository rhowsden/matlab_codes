
dim=25;
chargesize=5;
outV=10;
ite=10000;
method=1;
block=dim/chargesize;
x=chargesize*floor(block/2)+1;
y=x+chargesize-1;
rho=1;
Init = zeros(dim);
Init(1,:)=outV;
Init(:,1)=outV;
Init(dim,:)=outV;
Init(:,dim)=outV;
Init(x:y,x:y)=rho;

if method==1
    for i=1:ite;
        z=Init;
        Init = (circshift(z,1)+circshift(z,-1)+circshift(z,[0,1])+circshift(z,[0,-1]))/4;
        Init(1,:)=outV;
        Init(:,1)=outV;
        Init(dim,:)=outV;
        Init(:,dim)=outV;
        Init(x:y,x:y)=rho;
    end
    
elseif method==2
    for i=1:ite;
        z=Init;
        for j=2:dim-1;
            for k=2:dim-1;
                Init(j,k)=(z(j+1,k)+z(j-1,k)+z(j,k+1)+z(j,k-1))/4;
                Init(x:y,x:y)=rho;
            end
        end
    end
end

Init
cross = Init(ceil(dim/2),:)
D = diag(Init)