%limpieza
clear all;
close all;
clc;

%Cargar datos
data=xlsread('Gato.xlsx', 'Hoja1', 'J1:S700');


%% Regresión Logística
X=data(:,1:9); %Variables de Entrada 
media=mean(X);
desviacion=std(X);
Xtemp=bsxfun(@minus,X,mean(X));
X=bsxfun(@rdivide,Xtemp,std(X));

Y=data(:,10); %Salidas

cv = cvpartition(Y,'holdout',0.1);
% holdout: divide aleatoriamente las observaciones en un conjunto de datos
% de entrenamiento y prueba, usando la información de la clase del grupo.
% Datos de entrenamiento.
Xtrain = X(training(cv),:);
Ytrain = Y(training(cv));
% Datos de prueba.
Xtest = X(test(cv),:);
Ytest = Y(test(cv));

grado=2;
Xa=func_polinomio(Xtrain,grado);

W=zeros(size(Xa,2),1);  %Pesos iniciales

options=optimset('GradObj','on','MaxIter',1000); %Configuración de opciones

[Wopt,Jopt]=fminunc(@(W)fun_costo(W,Xa,Ytrain),W,options);

%% Simular con el modelo obtenido Entrenamiento
V=Xa*Wopt;
Yg=1./(1+exp(-V));
Yg=round(Yg);  %Salida numérica
%Yg=(Yg>=0.5);  %Salida Booleana o lógica

%% Medidas de Desempeño
TP= sum((Ytrain==1)&(Yg==1)); %True Positive
TN= sum((Ytrain==0)&(Yg==0)); %True Negative
FP= sum((Ytrain==0)&(Yg==1)); %False Positive
FN= sum((Ytrain==1)&(Yg==0)); %False Negative

Accu=(TP+TN)/(TP+TN+FP+FN); %Exactitud
Pre=TP/(TP+FP);  %Precisión
Rec=TP/(TP+FN);  %Recall

[Accu Pre Rec]

% Simulación de la Prueba (Test)
Xatest=func_polinomio(Xtest,grado);
Vtest=Xatest*Wopt;
Ygtest=1./(1+exp(-Vtest));
Ygtest=round(Ygtest);

TPtest= sum((Ytest==1)&(Ygtest==1)); %True Positive
TNtest= sum((Ytest==0)&(Ygtest==0)); %True Negative
FPtest= sum((Ytest==0)&(Ygtest==1)); %False Positive
FNtest= sum((Ytest==1)&(Ygtest==0)); %False Negative

Accutest=(TPtest+TNtest)/(TPtest+TNtest+FPtest+FNtest); %Exactitud
Pretest=TPtest/(TPtest+FPtest);  %Precisión
Rectest=TPtest/(TPtest+FNtest);  %Recall

[Accu Pre Rec; Accutest Pretest Rectest]

Mtrain=confusionmat(Ytrain,Yg);
confusionchart(Mtrain)

Mtest=confusionmat(Ytest,Ygtest);
confusionchart(Mtest)

%Clasificar nuevos datos
ndatos=[2 1 1 2 0 2 2 1 0; 2 0 1 1 2 2 1 0 2; 1 1 0 0 0 0 2 2 2; 1 2 2 0 2 2 1 1 1; 0 2 1 2 2 1 2 1 1]

temp=bsxfun(@minus,ndatos,media);
datosest=bsxfun(@rdivide,temp,desviacion);
Xaclasificar=func_polinomio(datosest,grado);

Vclasificar=Xaclasificar*Wopt;
Ygclasificar=1./(1+exp(-Vclasificar));
Ygclasificar=round(Ygclasificar)