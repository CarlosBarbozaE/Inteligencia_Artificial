%% Proyecto 2 MIA :Regresion Logistica Perceptron
%% Limpieza
clear all; 
close all; 
clc;
%% CARGAR DATOS
dataa=xlsread('Datos_Proyecto2.xlsx','clasif1','A1:F311'); %Clasificador 1
%dataa=xlsread('Datos_Proyecto2.xlsx','clasif2','A1:D311'); %Clasificador 2
%dataa=xlsread('Datos_Proyecto2.xlsx','clasif3','A1:C311'); %Clasificador 3
%DATOS PUNTO 3  
data1=xlsread('Datos_Proyecto2.xlsx','punto3','b12:f15'); %Clasificador 1
%data1=xlsread('Datos_Proyecto2.xlsx','punto3','j12:l15'); %Clasificador 2
%% Normalizacion De datos
for i=1:size(dataa,2)-1
    media(i)=mean(dataa(:,i));
    desvest(i)=std(dataa(:,i));
    data(:,i)=(dataa(:,i)-media(i))/desvest(i);
end 
%% Normalizacion datos para el punto 3
for i=1:size(data1,2)
    media1(i)=mean(data1(:,i));
    desvest1(i)=std(data1(:,i));
    data1f(:,i)=(data1(:,i)-media1(i))/desvest1(i);    
end
%% REGRESION LOGISTICA
X=data(:,1:5);%Clasificador 1
%X=data(:,1:3);%Clasificador 2
%X=data(:,1:2);%Clasificador 3
Y=dataa(:,6);%Clasificador 1
%Y=dataa(:,4);%Clasificador 2
%Y=dataa(:,3);%Clasificador 3
ngrado = 4;%Clasificador 1
%ngrado = 5;%Clasificador 2
%ngrado = 6;%Clasificador 3
[Xa, coef]=func_polinomio(X, ngrado);
W=zeros(size(Xa,2),1);
[J,dIdW]=func_costo(W,Xa,Y);
options=optimset('GradObj','on','MaxIter',1000); %Minimizar Metodo gradiente descendente maximo 1000 iteraciones 
[Wopt,Jopt]=fminunc(@(W)func_costo(W,Xa,Y),W,options); %Minimizando J obtiene las W (peso)
%% SIMULACION DEL MODELO OBTENIDO 
V=Xa*Wopt;
Yg=1./(1+exp(-V));
Yg=(Yg>=.5); %valores mayores a .5 les pone 1 sino 0 
TP=sum((Y==1)&(Yg==1)); %True positives 
TN=sum((Y==0)&(Yg==0));
FP=sum((Y==0)&(Yg==1));
FN=sum((Y==1)&(Yg==0));
Accu=(TP+TN)/(TP+TN+FP+FN); %Exactitud
Pre=TP/(TP+FP); %Precision
Rec=TP/(TP+FN); %Recall
F1=2*((Pre*Rec)/(Pre+Rec));%F1
verifications=[Accu Pre Rec F1]
%% V y Y para las estimaciones del punto 3
V_est1=func_polinomio(data1f, ngrado);
V_est1f=V_est1*Wopt;
Yg_est=1./(1+exp(-V_est1f));
Yg_est=(Yg_est>=.5)
%% DIBUJAR LA FRONTERA
bar(Wopt) %ver si hay overfitting 
title('Coeficientes de las Variables')