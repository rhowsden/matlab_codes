function Square(n)
pixels=10^n;
length=pixels/(3^n);
fractize(0,0,pixels,0,ceil(length));

function fractize(x1,y1,x6,y6,smallest)   
section=sqrt((x6-x1)^2+(y6-y1)^2); 
if(section>smallest)
   x2=(2*x1+x6)/3;
   y2=(2*y1+y6)/3;
   x3=(2*x1+y1+x6-y6)/3;
   y3=(-x1+2*y1+x6+y6)/3;
   x4=(x1+y1+2*x6-y6)/3;
   y4=(-x1+y1+x6+2*y6)/3;
   x5=(2*x6+x1)/3;
   y5=(2*y6+y1)/3;
   fractize(x1,y1,x2,y2,smallest);
   fractize(x2,y2,x3,y3,smallest);
   fractize(x3,y3,x4,y4,smallest);
   fractize(x4,y4,x5,y5,smallest);
   fractize(x5,y5,x6,y6,smallest);
else 
   connectdots(x1,y1,x6,y6); 
end

function connectdots(a1,b1,a2,b2)
x=[a1;a2];
y=[b1;b2];
axis equal
set(gca,'Visible','off')
set(gcf,'Name','Koch Square')
line(x,y, 'Color','r');


