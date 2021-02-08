%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% ALGORITMO DE TRADING USANDO UN PROMEDIO MOVIL %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
close all;
clc;

%% Obteniendo los datos que serán usandos para simular el algoritmo de trading
hoy=datestr(date,23);
inicio=datestr(datenum(date)-365,23);
data = downloadValues('GRUMAB.MX',inicio,hoy,'d','history');
precios = data.AdjClose; %Seleccionar los precios de cierre

%% Algoritmo de trading basado en un promedio movil
npm = 9; %Número de días usados para calcular el promedio móvil
cap = 10000*ones(size(precios)); %Capital inicial a invertir
nac = 0*ones(size(precios)); %Número de acciones disponibles al inicio de la simulación
com = 0.0029; %Comisión por operación

% Simulación del algoritmo
for t = 0:size(precios,1)-npm
    pm(npm+t,1) = mean(precios(t+1:npm+t,1)); %Calculando el promedio movil
    
    if pm(npm+t,1)<precios(npm+t,1)
        % Comprar, si el promedio movil es más grande que el precio actual
        u = floor((cap(npm+t,1))/((1+com)*precios(npm+t,1)));
    else
        % Vender, si el promedio movil es más pequeño que el precio actual
        u = -nac(npm+t,1);
    end
    nac(npm+t+1,1) = nac(npm+t,1)+u;
    cap(npm+t+1,1) = cap(npm+t,1)-precios(npm+t,1)*u-com*precios(npm+t,1)*abs(u);
end

%% Visualización de los resultados
T = (1:size(precios,1))';
figure(1);
subplot(4,1,1);
plot(T,precios,'b-',T(npm:end),pm(npm:end),'r--');
title(sprintf('Promedio Movil a %d días',npm)),xlabel('# dias'), ylabel('precio');
legend('precio','promedio','Location','NorthEastOutside');
grid;
subplot(4,1,2);
plot(T,nac(1:end-1,1),'b-');
xlabel('# dias'), ylabel('# acciones');
legend('# acciones','Location','NorthEastOutside');
grid;
subplot(4,1,3);
plot(T,cap(1:end-1,1),'b-');
xlabel('# dias'), ylabel('$');
legend('capital','Location','NorthEastOutside');
grid;
subplot(4,1,4);
plot(T,100*(cap(1:end-1,1)+precios.*nac(1:end-1,1)-cap(1,1))/cap(1,1),'b-');
xlabel('# dias'), ylabel('rendimiento (%)');
legend('Total','Location','NorthEastOutside');
grid;