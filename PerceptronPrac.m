clear all;
close all;
clc;
%% Regresion logistica
load simpleclusterInputs.mat
load simpleclusterOutputs.mat
data = simpleclusterInputs;
x = data(1:2,:); % Entradas
y = simpleclusterTargets(1,:); %Salidas
x = x';
y = y';

m = size(x,1); % Cantidad de datos

grado=2;
xa = func_polinomio(x,grado);
w = zeros(size(xa,2),1);

%%
[J, dJdW] = fun_costo(w,xa,y);

options = optimset('GradObj','on','MaxIter',1000); %Configuracion de opciones

[Wobt, Jopt] = fminunc(@(w)fun_costo(w,xa,y),w,options); %Pesos optimos

v = xa*Wobt;
yg = 1./(1+exp(-v));
yg = round(yg);
%yg = (yg>=.5); % Con este las salidas son booleano

%% Medidas de desempe;o
TP = sum((y==1)&(yg==1));
TN = sum((y==0)&(yg==0));
FP = sum((y==0)&(yg==1));
FN = sum((y==1)&(yg==0));


accu = (TP+TN)/(TP+TN+FP+FN); % Exactitud
pre = (TP)/(TP+FP);
rec = TP/(TP+FN);

[accu pre rec]
