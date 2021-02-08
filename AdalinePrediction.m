clear all;
close all;
clc;

res = downloadValues('CMG', '03/10/2015', '03/15/2016','d','history');
precios = res.AdjClose;

nrez = 3;
x = [];

for k=0:nrez
    x = [x, precios(nrez+1-k:end-k)]
end

y = x(:,1); %Datos mas actuales
xa = [ones(size(x,1),1) x(:,2:end)];

ntrain = round(0.6*size(xa,1))
xa_train=xa(1:ntrain,:);
xa_test=xa(ntrain+1:end,:);
y_train=y(1:ntrain,:);
y_test=y(ntrain+1:end,:);

wmc = inv(xa_train'*xa_train)*xa_train'*y_train;
yg_mc = xa *wmc;

%% Simulacion de datos conocidos en zona test
yg_rec = xa_train*wmc;
xtemp = xa_train(end,:);

for k=ntrain+1 : size(xa,1)
    xtemp = [1 yg_rec(k-1,1) xtemp(:,2:end-1)];
    yg_rec(k,1) = xtemp*wmc;
end

plot([1:size(y,1)]', y, 'b-', [1:size(yg_mc,1)]', yg_mc, 'r-',...
    [1:size(yg_rec,1)]', yg_rec, 'g-');
legend('precios', 'estimado k+1')
grid;



