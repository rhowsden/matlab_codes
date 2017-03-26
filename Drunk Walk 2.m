ttotal = 0;
n=0;
x = zeros(31, 1);

while (n<10000)
i=1;
t = 0;
    while (i < 30)
        if (i < 1)
            break
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
x(2)=x(2)+10000;
x
tave = ttotal/n
