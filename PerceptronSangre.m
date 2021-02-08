clear all;
close all;
clc;

load BaseSangre.txt
data = BaseSangre;
x = data(:, 1:4); % Entradas
y = data(:,5); %Salidas

xtemp = bsxfun(@minus,x,mean(x));
x = bsxfun(@rdivide,xtemp,std(x));

cv = cvpartition(y,'holdout',0.2);
xtrain = x(training(cv),:);
ytrain = y(training(cv));

xtest = x(test(cv),:);
ytest = y(test(cv));

m = size(x,1); % Cantidad de datos

grado=3;
xatrain = func_polinomio(xtrain,grado);
w = zeros(size(xatrain,2),1);

%%
[J, dJdW] = fun_costo(w,xatrain,ytrain);

options = optimset('GradObj','on','MaxIter',1000); %Configuracion de opciones

[Wobt, Jopt] = fminunc(@(w)fun_costo(w,xatrain,ytrain),w,options); %Pesos optimos

v = xatrain*Wobt;
yg = 1./(1+exp(-v));
yg = round(yg);
%yg = (yg>=.5); % Con este las salidas son booleano

%% Medidas de desempe;o
TP = sum((ytrain==1)&(yg==1));
TN = sum((ytrain==0)&(yg==0));
FP = sum((ytrain==0)&(yg==1));
FN = sum((ytrain==1)&(yg==0));


accu = (TP+TN)/(TP+TN+FP+FN); % Exactitud
pre = (TP)/(TP+FP);
rec = TP/(TP+FN);

%% 
xatest = func_polinomio(xtest, grado);
w = zeros(size(xatest,2),1);

%%
[Jtest, dJdWtest] = fun_costo(w,xatest,ytest);

options = optimset('GradObj','on','MaxIter',1000); %Configuracion de opciones

[Wobttest, Jopttest] = fminunc(@(w)fun_costo(w,xatest,ytest),w,options); %Pesos optimos

v = xatest*Wobttest;
ygtest = 1./(1+exp(-v));
ygtest = round(ygtest);
%yg = (yg>=.5); % Con este las salidas son booleano

%% Medidas de desempe;o
TPtest = sum((ytest==1)&(ygtest==1));
TNtest = sum((ytest==0)&(ygtest==0));
FPtest = sum((ytest==0)&(ygtest==1));
FNtest = sum((ytest==1)&(ygtest==0));


accutest = (TPtest+TNtest)/(TPtest+TNtest+FPtest+FNtest); % Exactitud
pretest = (TPtest)/(TPtest+FPtest);
rectest = TPtest/(TPtest+FNtest);

[accu pre rec; accutest pretest rectest]

