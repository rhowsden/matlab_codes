M1 = [cos(x) -i*sin(x)/1.1;-i*1.1*sin(x) cos(x)];
M2 = [cos(2*x) -i*sin(2*x)/1.2;-i*1.2*sin(2*x) cos(2*x)];
M3 = [cos(3*x), -i*sin(3*x)/1.1;-1*1.1*sin(3*x) cos(3*x)];
M = M1*M2*M3

reflection = (M(1,1)+M(1,2)-M(2,1)-M(2,2))/(M(1,1)+M(1,2)+M(2,1)+M(2,2))
transmission =(2/(M(1,1)+M(1,2)+M(2,1)+M(2,2)))

r(x) = abs(reflection)^2
t(x) = abs(transmission)^2
