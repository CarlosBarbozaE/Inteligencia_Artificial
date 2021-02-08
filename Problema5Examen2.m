clear all;
close all;
clc;

data=xlsread('ENB2012_data.xlsx','Entrena','A2:J769');

x = data(:,1:8);
y = data(:,9:10);

ndatos=round(0.8*size(x,1));
xtrain = x(1:ndatos,:);
xtest = x(ndatos+1:end,:);
ytrain = y(1:ndatos,:);
ytest = y(ndatos+1:end,:);

media=mean(xtrain);
desviacion=std(xtrain);
xtemp=bsxfun(@minus,xtrain,media);
xtrain=bsxfun(@rdivide, xtemp,desviacion);

% red = feedforwardnet([10 10 10]);
% red.trainFcn = 'trainlm';
% 
% red = train(red,xtrain', ytrain');

load eje5modelo.mat
%Simular
ygtrain = red(xtrain');
J1=perform(red, ytrain', ygtrain);

xtemp1=bsxfun(@minus,xtest,media);
xtest=bsxfun(@rdivide, xtemp1,desviacion);
ygtest = red(xtest');
J2 = perform(red,ytest',ygtest);

[J1 J2]

datospred = xlsread('ENB2012_data.xlsx','Predecir','A2:H25');
xpre = datospred(:,1:8);
xtemp=bsxfun(@minus,xpre,media);
xtrain=bsxfun(@rdivide, xtemp,desviacion);
ypred = red(xtrain');


