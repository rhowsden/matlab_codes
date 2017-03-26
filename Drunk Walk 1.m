ttotal = 0;
n=0;
twenty = zeros(1,31);
x = zeros(1,31);
start = 10;

while (n<10000)
i=start;
t = 0;
    while (i < 30)
        if (i < 1)
            break
        end
        if t==20,
            twenty(i+1)=twenty(i+1)+1;
        end  
        turtle = rand(1);
        if turtle > .5,
            i = i + 1;
        else
            i = i - 1;
        end
        x(i+1)= x(i+1) + 1;  
        t = t+1;
    end
ttotal = ttotal + t;
n=n+1;
end
x(start+1)=x(start+1)+10000;
twentynorm=twenty/sum(twenty);
xnorm=x/sum(x);
tave = ttotal/n

plot(twentynorm)
hold on
plot(xnorm)
