clear all;
close all;
clc;

data=xlsread('audit_risk.xlsx','audit_risk','A2:AB774');

grado=1;
x = data(:,[3 4 5 6 7 8 9 12 13 14 15 16 18 19 21 22 23 24 25 27]);
media=mean(x);
desviacion=std(x);
xtemp=bsxfun(@minus,x,mean(x));
x=bsxfun(@rdivide, xtemp,std(x));

y = data(:,28);

cv = cvpartition(y,'holdout',0.1);
% holdout: divide aleatoriamente las observaciones en un conjunto de datos
% de entrenamiento y prueba, usando la información de la clase del grupo.
% Datos de entrenamiento.
Xtrain = x(training(cv),:);
Ytrain = y(training(cv));
% Datos de prueba.
Xtest = x(test(cv),:);
Ytest = y(test(cv));





Xa=func_polinomio(Xtrain,grado);

w=zeros(size(Xa,2),1);

options = optimset('GradObj','on','MaxIter',1000); %Configuracion de opciones

[Wobt, Jopt] = fminunc(@(w)fun_costo(w,Xa,Ytrain),w,options); %Pesos optimos

v = Xa*Wobt;
yg = 1./(1+exp(-v));
yg = round(yg);
%yg = (yg>=.5); % Con este las salidas son booleano

%% Medidas de desempe;o
TP = sum((Ytrain==1)&(yg==1));
TN = sum((Ytrain==0)&(yg==0));
FP = sum((Ytrain==0)&(yg==1));
FN = sum((Ytrain==1)&(yg==0));


accu = (TP+TN)/(TP+TN+FP+FN); % Exactitud
pre = (TP)/(TP+FP);
rec = TP/(TP+FN);


Xatest=func_polinomio(Xtest,grado);
Vtest=Xatest*Wobt;
Ygtest=1./(1+exp(-Vtest));
Ygtest=round(Ygtest);

TPtest= sum((Ytest==1)&(Ygtest==1)); %True Positive
TNtest= sum((Ytest==0)&(Ygtest==0)); %True Negative
FPtest= sum((Ytest==0)&(Ygtest==1)); %False Positive
FNtest= sum((Ytest==1)&(Ygtest==0)); %False Negative

Accutest=(TPtest+TNtest)/(TPtest+TNtest+FPtest+FNtest); %Exactitud
Pretest=TPtest/(TPtest+FPtest);  %Precisión
Rectest=TPtest/(TPtest+FNtest);  %Recall

[accu pre rec; Accutest Pretest Rectest]

ndatos=[0.51 0.2 0.102 .23 .2 .046 .74 .2 1 0 0.2 0 0.2 0.4 0.2 0 2 1.548 0.4 0.3096; 0 0.2 0 10.8 0.6 6.48 10.8 0.6 3.6 11.75 0.6 7.05 0.2 0.4 0.2 0 4.4 17.53 0.4 3.506];

temp=bsxfun(@minus,ndatos,media);
datosest=bsxfun(@rdivide,temp,desviacion);
Xaclasificar=func_polinomio(datosest,grado);

Vclasificar=Xaclasificar*Wobt;
Ygclasificar=1./(1+exp(-Vclasificar));
Ygclasificar=round(Ygclasificar)