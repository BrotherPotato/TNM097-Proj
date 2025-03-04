function [L,a,b]=xyz2lab(x,y,z)

Xn = 97.9426;
Yn = 100.00;
Zn = 117.9169;

ylim = Yn*0.008856;
L = (y>ylim).*(116*(y/Yn).^(1/3)-16)+(y<=ylim).*(903.3*y/Yn);
ytemp = foo(y/Yn);
a = 500*(foo(x/Xn)-ytemp);
b = 200*(ytemp-foo(z/Zn));


function y = foo(x)

y=(x<=0.008856).*(7.787*x+16/116)+(x>0.008856).*x.^(1/3);