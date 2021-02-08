clear all;
close all;
clc;

%% Minimos cuadrados
data = xlsread('Regresión.xlsx', 'Problema 3', 'A2:D201');
x1 = data(:,2);
x2 = data(:,1);
x3 = data(:,3);
x = [x1 x2 x3];
y = data(:,4);
grado = 8;
m = size(x1,1); 
% x* es el modelo con el que se va a construir la regresion

for i=1:grado
    Xa=func_polinomio(x,i);
    Wmc=inv(Xa'*Xa)*Xa'*y; %Cálculo de Pesos
    yg_mc=Xa*Wmc;   %La salida estimada
    E=y-yg_mc;   %Error
    J(i,1)=(E'*E)/(2*m);  %Función de Costo
end

%% Gradiente descendente
xa = ones(m,1);

for i = 1 : grado
    xa = [xa x.^i];
end

eta = 1.2; %Velociadad de convergencia
wgd = rand(size(xa,2),1);
for k =1:100000
    yg_gd = xa*wgd; %Salida estimada con grad desc.
    E = y-yg_gd;
    J2(k,1) =E'*E/(2*m);
    djdw = -E'*xa/m;
    wgd = wgd - eta*djdw';
end
yg_gd = xa*wgd;

[wgd]
[Wmc]

