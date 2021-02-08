clear all;
close all;
clc;

load red_wine.txt;
data = red_wine;

x = data(:,1:11);
y = data(:,12);

%Particion de datos
cv = cvpartition(y,'holdout',0.25);
% holdout: divide aleatoriamente las observaciones en un conjunto de datos
% de entrenamiento y prueba, usando la información de la clase del grupo.
% Datos de entrenamiento.
Xtrain = x(training(cv),:);
Ytrain = y(training(cv));
% Datos de prueba.
Xtest = x(test(cv),:);
Ytest = y(test(cv));

%Normalizacion de datos
media=mean(Xtrain);
desviacion=std(Xtrain);
xtemp=bsxfun(@minus,Xtrain,media);
Xtrain=bsxfun(@rdivide, xtemp,desviacion);

xtemp2=bsxfun(@minus,Xtest,media);
Xtest=bsxfun(@rdivide, xtemp2,desviacion);

%Profe
red=feedforwardnet([9 7 10]);
red.trainFcn='trainrp';
red=train(red,Xtrain',Ytrain');
%Simulacion train
ygtrain=red(Xtrain');
ygtrain =round(ygtrain');

mat1=confusionmat(Ytrain,ygtrain)
figure(1)
confusionchart(mat1)
J1=perform(red,Ytrain,ygtrain)
%Simulacion test
ygtest=red(Xtest');
ygtest =round(ygtest');

mat2=confusionmat(Ytest,ygtest)
figure(2)
confusionchart(mat2)
J2=perform(red,Ytest,ygtest)

% Medidas de exactitud
%Exactitud
extrain = ((mat1(1,1) + mat1(2,2) + mat1(3,3)+mat1(4,4)+mat1(5,5)+mat1(6,6)) / round((size(x,1))*0.75));
extest = ((mat2(1,1) + mat2(2,2)+ mat2(3,3)+mat2(4,4)+mat2(5,5)+mat2(6,6)) / round((size(x,1))*0.25));
%Precision
col3 = mat1(:,3);
col4 = mat1(:,4);
col5 = mat1(:,5);
prectrain = ((mat1(3,3)/sum(col3')) + (mat1(4,4)/sum(col4')+ (mat1(5,5)/sum(col5')))) / 3;
col3t = mat2(:,3);
col4t = mat2(:,4);
col5t = mat2(:,5);
prectest = ((mat2(3,3)/sum(col3t')) + (mat2(4,4)/sum(col4t')+ (mat2(5,5)/sum(col5t')))) / 3;
%Recall
fil1 = mat1(1,:);
fil2 = mat1(2,:);
fil3 = mat1(3,:);
fil4 = mat1(4,:);
fil5 = mat1(5,:);
fil6 = mat1(6,:);
rectrain = ((mat1(1,1)/sum(fil1)) + (mat1(2,2)/sum(fil2) + (mat1(3,3)/sum(fil3)+ (mat1(4,4)/sum(fil4)+ (mat1(5,5)/sum(fil5)+ (mat1(6,6)/sum(fil6))))))) / 6;
fil1t = mat2(1,:);
fil2t = mat2(2,:);
fil3t = mat2(3,:);
fil4t = mat2(4,:);
fil5t = mat2(5,:);
fil6t = mat2(6,:);
rectest = ((mat2(1,1)/sum(fil1t)) + (mat2(2,2)/sum(fil2t)+ (mat2(3,3)/sum(fil3t)+ (mat2(4,4)/sum(fil4t)+ (mat2(5,5)/sum(fil5t)+ (mat2(6,6)/sum(fil6t))))))) / 6;

[extrain prectrain rectrain; extest prectest rectest]

datos=xlsread('Vinos.xlsx','Hoja1','A2:K6');
xpred = datos(:,1:11);
xtemp=bsxfun(@minus,xpred,media);
xpred=bsxfun(@rdivide, xtemp,desviacion);
ypred = red(xpred');