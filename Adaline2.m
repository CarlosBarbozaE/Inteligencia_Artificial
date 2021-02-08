clear all;
close all;
clc;

%% Minimos cuadrados
x1 = datoselec(:,2);
x2 = datoselec(:,1);
y = datoselec(:,3);

m = size(x1,1); 
% x* es el modelo con el que se va a construir la regresion
xa = [ones(m,1) x1 x1.^2 x2 x1.*x2 (x1.^2).*x2]
wmc = inv(xa'*xa)*xa'*y;
yg_mc = xa * wmc;
E = y - yg_mc;
J = (E'*E)/(2*m);

%for i = 1 : grado
%    xa = [xa x.^i];
%    wmc = inv(xa'*xa)*xa'*y;
%    yg_mc = xa * wmc;
%    E = y - yg_mc;
%    J(i,1) = (E'*E)/(2*m);
%end


%% Gradiente descendente
m = size(x,1); 

xa = ones(m,1);

for i = 1 : grado
    xa = [xa x.^i];
end

eta = 1.2; %Velociadad de convergencia
wgd = rand(size(xa,2),1);
for k =1:100000
    yg_gd = xa.*wgd; %Salida estimada con grad desc.
    E = y-yg_gd;
    J(k,1) =(E'*E)/(2*m);
    djdw = -E'*xa/m;
    wgd = wgd - eta*djdw;
end
yg_gd = xa*wgd;

subplot(1,2,1);
plot(x,y,'b.',x,yg_mc,'r.',x,yg_gd,'g.')
subplot(1,2,2);
plot(J,'b.') % J de gradiente descendente

[wmc wgd]