%CON PARTICI�N DE DATOS 

clear all;
close all;
clc;

%Cargar datos
load datos2.mat;
data=datos2;
X=data(:,[1 2]);      %Se puede modificar para ver las varialbes
Y=data(:,3);  

%ESTA FUNCI�N AUTOMATIZA EL SEPARAR (SOLO DATOS DE CLASIFICACI�N NO REGRESI�N)
cv=cvpartition(Y,'holdout',0.2) %da informaci�n de los datos separados
% holdout: divide aleatoriamente las observaciones en un conjunto de datos
% de entrenamiento y prueba, usando la informaci�n de la clase del grupo.
% Datos de entrenamiento.
Xtrain = X(training(cv),:);
Ytrain = Y(training(cv));
% Datos de prueba.
Xtest = X(test(cv),:);
Ytest = Y(test(cv));

n=size(Xtrain,1);

grado=2;     

Xa=func_polinomio(Xtrain,grado);
W=zeros(size(Xa,2),1);

[J,dJdW]=fun_costo(W,Xa,Ytrain);

options=optimset('GradObj', 'on', 'MaxIter', 1000);
[Wopt, Jopt]=fminunc(@(W)fun_costo(W,Xa,Ytrain), W, options); %guardar los pesos cuando 
                                                              %te da un modelo buenas m�tricas
                                                              %le das save en workspace "save as"