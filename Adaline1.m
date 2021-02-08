clear all;
close all;
clc;
%% Borrar esta seccion
x = rand(100,1); %Se generan 100 numoer aleatorios.
y = 15-3*x+4*x.^2-6*x.^4; %Funcion conocida
grado = 4;

%% Minimos cuadrados
m = size(x,1); 
% x* es el modelo con el que se va a construir la regresion
xa = ones(m,1);

for i = 1 : grado
    xa = [xa x.^i];
    wmc = inv(xa'*xa)*xa'*y;
    yg_mc = xa * wmc;
    E = y - yg_mc;
    J(i,1) = (E'*E)/(2*m);
end


%% Gradiente descendente
m = size(x,1); 

xa = ones(m,1);

for i = 1 : grado
    xa = [xa x.^i];
end

eta = 1.2; %Velociadad de convergencia
wgd = rand(size(xa,2),1);
for k =1:100000
    yg_gd = xa*wgd; %Salida estimada con grad desc.
    E = y-yg_gd;
    J(k,1) =E'*E/(2*m);
    djdw = -E'*xa/m;
    wgd = wgd - eta*djdw';
end
yg_gd = xa*wgd;

subplot(1,2,1);
plot(x,y,'b.',x,yg_mc,'r.',x,yg_gd,'g.')
subplot(1,2,2);
plot(J,'b.') % J de gradiente descendente

[wmc wgd]