clear all;
close all;
clc;

% cargar datos 
load datos4.mat
data = IPCfinal(:,5);
nrez = 3; %cuantos rezagos quiero
temp=[];

for k=0:nrez
    temp(:,k+1) = data(nrez+1-k:end-k);
end