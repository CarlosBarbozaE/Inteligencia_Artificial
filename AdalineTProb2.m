clear all;
close all;
clc;

%% Minimos cuadrados
data = xlsread('Regresión.xlsx', 'Problema 2', 'A2:C301');
x1 = data(:,2);
x2 = data(:,1);
x = [x1 x2];
y = data(:,3);
grado = 2;
m = size(x1,1); 
% x* es el modelo con el que se va a construir la regresion
xa = [ones(m,1) x1 x1.^2 x2 x1.*x2 (x1.^2).*x2];
wmc = inv(xa'*xa)*xa'*y;
yg_mc = xa * wmc;
E = y - yg_mc;
J = (E'*E)/(2*m);

% Función polinomio
for i=1:grado
    Xa=func_polinomio(x,i);
    Wmc=inv(Xa'*Xa)*Xa'*y; %Cálculo de Pesos
    Yg_mc=Xa*Wmc;   %La salida estimada
    Er=y-Yg_mc;   %Error
    J(i,1)=(Er'*Er)/(2*m);  %Función de Costo
end

[wmc]
[Wmc]
