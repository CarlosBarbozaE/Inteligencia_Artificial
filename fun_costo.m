function [J,dJdW] = fun_costo(w,xa,y)

v = xa*w;
yg = 1./(1+exp(-v));

m = size(xa,1);
J = sum(-y.*log(yg)-(1-y).*log(1-yg));
E = yg-y;
dJdW = (E'*xa)'/m; %Gradiente
end