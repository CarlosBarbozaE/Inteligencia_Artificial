clear all;
close all;
clc;

load data1.txt
data = data1;

G0 = data(data(:,3)==0,1:2); %Grupoo cero
G1 = data(data(:,3)==1,1:2); %Grupo uno

plot(G0(:,1),G0(:,2),'bo',G1(:,1),G1(:,2),'rx')

%% Regresion logistica
x = data(:,1:2); % Entradas
y = data(:,3); %Salidas

m = size(x,1); % Cantidad de datos
xa = [ones(m,1) x.^2];

w = zeros(size(xa,2),1);

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

%% Se puede borrar el dibujo de la frontera
x1 = 30:0.1:100;
x2 = 30:0.1:100;

[x1,x2] = meshgrid(x1,x2);
[m,n] = size(x1);

x1temp = reshape(x1,m*n, 1);
x2temp = reshape(x2,m*n, 1);

ytemp = [ones(m*n,1) x1temp.^2 x2temp.^2]*Wobt;

ytemp = reshape(ytemp,m,n);

plot(G0(:,1),G0(:,2),'bo',G1(:,1),G1(:,2),'rx')
hold on;
contour(x1,x2,ytemp,[0 0], 'LineWidth',2);
hold off;
