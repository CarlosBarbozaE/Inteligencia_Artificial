clear all;
close all;
clc;

load toxicidadAgua.txt
data = toxicidadAgua;

x=data(:,1:8);
y=data(:,9);
media=mean(x);
desviacion=std(x);
xtemp=bsxfun(@minus,x,media);
x=bsxfun(@rdivide,xtemp,desviacion);

m=size(x,1);

grado=3;

for i = 1 : grado
    xa = func_polinomio(x,i);
    wmc = inv(xa'*xa)*xa'*y;
    yg_mc = xa * wmc;
    E = y - yg_mc;
    J(i,1) = (E'*E)/(2*m);
end
    
plot(J,'b')
xlabel('Grado del polinomio')
ylabel('J(x,w)')

xreg=[38.57 6.249 0 0.59 1.7 0 2 0];
xregtemp=bsxfun(@minus,xreg,media);
xreg=bsxfun(@rdivide,xregtemp,desviacion);
xareg=func_polinomio(xreg,3);
yestimada=xareg*wmc

