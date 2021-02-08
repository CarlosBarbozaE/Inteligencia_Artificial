clear all;
close all;
clc;

load ex_mia4_data1.mat;
data = train;

clear train; %Para borrarla

x = data(:,1:3);
y = data(:, 4);

cv = cvpartition(y,'holdout',0.1);
% holdout: divide aleatoriamente las observaciones en un conjunto de datos
% de entrenamiento y prueba, usando la información de la clase del grupo.
% Datos de entrenamiento.
Xtrain = x(training(cv),:);
Ytrain = y(training(cv));
% Datos de prueba.
Xtest = x(test(cv),:);
Ytest = y(test(cv));

media = mean(Xtrain);
desv = std(Xtrain);
temp = bsxfun(@minus, Xtrain, media);
Xtrain = bsxfun(@rdivide, temp, desv);

red = feedforwardnet(10);
red.trainFcn = 'trainrp';
red = train(red,Xtrain',Ytrain');

temp1 = bsxfun(@minus, Xtest, media);
Xtest = bsxfun(@rdivide, temp1, desv);
ygtest = red(Xtest');
ygtest = round(ygtest);

J = perform(red,Ytest',ygtest)

mat1 = confusionmat(ygtest',ygtest);
figure(1)
confusionchart(mat1)
