function Triangle(n)
pixels=10^n;
length=pixels/(3^n);  
fractize(0,0,pixels,0,ceil(length));

function fractize(x1,y1,x5,y5,smallest)   
section=sqrt((x5-x1)^2+(y5-y1)^2); 
if(section>smallest)
   x2=(2*x1+x5)/3;
   y2=(2*y1+y5)/3;
   x3=(x1+x5)/2-(y5-y1)/(2.0*sqrt(3.0));
   y3=(y1+y5)/2+(x5-x1)/(2.0*sqrt(3.0));
   x4=(2*x5+x1)/3;
   y4=(2*y5+y1)/3;
   fractize(x1,y1,x2,y2,smallest);
   fractize(x2,y2,x3,y3,smallest);
   fractize(x3,y3,x4,y4,smallest);
   fractize(x4,y4,x5,y5,smallest);
else 
   connectdots(x1,y1,x5,y5); 
end

function connectdots(a1,b1,a2,b2)
x=[a1;a2];
y=[b1;b2];
axis equal
set(gca,'Visible','off')
set(gcf,'Name','Koch Triangle')
line(x,y, 'Color','r');


