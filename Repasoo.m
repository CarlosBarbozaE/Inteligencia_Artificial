clear all;
close all;
clc;

load house.mat
data = house;

x = data(1:13,:);
y = data(14,:);
x = x';
ndatos=round(0.9*size(x,1));
xtrain = x(1:ndatos,:);
xtest = x(ndatos+1:end,:);
ytrain = y(:,1:ndatos);
ytest = y(:,ndatos+1:end);

media=mean(xtrain);
desviacion=std(xtrain);
xtemp=bsxfun(@minus,xtrain,media);
xtrain=bsxfun(@rdivide, xtemp,desviacion);

red = feedforwardnet(10);
red.trainFcn = 'trainlm';

red = train(red,xtrain', ytrain);
%Simular
ygtrain = red(xtrain');
J1=perform(red, ytrain, ygtrain);

xtemp1=bsxfun(@minus,xtest,media);
xtest=bsxfun(@rdivide, xtemp1,desviacion);
ygtest = red(xtest');
J2 = perform(red,ytest,ygtest);

[J1 J2]

xestim = [12.54 45 15.37 1 0.5150 6.1621 45.8 3.3751 7 193 15.2 347.88 2.96];
xtemp2=bsxfun(@minus,xestim,media);
xestim=bsxfun(@rdivide, xtemp2,desviacion);
yestim = red(xestim')


