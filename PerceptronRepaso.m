clear all;
close all;
clc;

data=xlsread('Datainmuno.xlsx','Hoja1','A2:H91');
data2=xlsread('Datainmuno.xlsx','Hoja1','A96:G98');

x = data(:,2:5);
media=mean(x);
desviacion=std(x);
xtemp=bsxfun(@minus,x,mean(x));
x=bsxfun(@rdivide, xtemp,std(x));

y = data(:,8);

grado=3;
xa=func_polinomio(x,grado);

w=zeros(size(xa,2),1);

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
bar(Wobt)

xclas = data2(:,2:5);
xtempclas=bsxfun(@minus,xclas,mean(x));
xclas=bsxfun(@rdivide, xtempclas,desviacion);

xaclas=func_polinomio(xclas,grado);

vclas = xaclas*Wobt;
ygclas = 1./(1+exp(-vclas));
ygclas = round(ygclas)

