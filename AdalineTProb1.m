clear all;
close all;
clc;

%% Minimos cuadrados
data = xlsread('Regresión.xlsx', 'Problema 1', 'A2:B201');
x = data(:,1);
y = data(:,2);
m = size(x,1); 
xa = ones(m,1);
grado = 3;
%% xa es el modelo con el que se va a construir la regresion
for i = 1 : grado
    xa = [xa x.^i];
    wmc = inv(xa'*xa)*xa'*y;
    yg_mc = xa * wmc;
    E = y - yg_mc;
    J(i,1) = (E'*E)/(2*m);
end

%% Gradiente descendente
xa = ones(m,1);

for i = 1 : grado
    xa = [xa x.^i];
end

eta = 1.2; %Velociadad de convergencia
wgd = rand(size(xa,2),1);
for k =1:10000000
    yg_gd = xa*wgd; %Salida estimada con grad desc.
    E = y-yg_gd;
    J2(k,1) =E'*E/(2*m);
    djdw = -E'*xa/m;
    wgd = wgd - eta*djdw';
end
yg_gd = xa*wgd;

subplot(1,2,1);
plot(x,y,'b.',x,yg_mc,'r.',x,yg_gd,'g.')
subplot(1,2,2);
plot(J,'b.') % J de gradiente descendente

[wmc wgd]

