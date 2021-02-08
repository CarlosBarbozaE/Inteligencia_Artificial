clear all; %borrar todas las variables
close all; %cerrar todas las ventanas
clc; %limpia la pantalla

%Algoritmo genetico con un cruzamineto un punto de cruce.

nbits=8; %numero de bits
np=64;  %cantidad de pobladores (de preferencia multiplo de 4)
%Generar la poblacion inicial
xpadres=randi([0,255],np,1);

for n=1:100 %Numero de generaciones
    %Evaluar la funcion
    y=-(xpadres-123).^2+100; %Definir la funcion de adaptacion
    yprom(n)=mean(y);
    %Cromosoma
    cromosoma= sortrows([xpadres y],2);

    %Seleccion
    padres=cromosoma(np/2+1:np,1); %Se tomaron los mejores 

    %Convertir a binario
    padresbin=de2bi(padres,nbits); 

    %Encontrar el cruzamiento
    %Un putno de cruce
    for k=1 : (np/4)
        n=randi([2,nbits-1]); %Punto de cruce aleatorio
        hijobin(2*k-1,:)= [padresbin(2*k-1,1:n) padresbin(2*k,n+1:nbits)];
        hijobin(2*k,:)= [padresbin(2*k,1:n) padresbin(2*k-1,n+1:nbits)];
    end
    
    %Mutacion
    p=rand();
    if p>0.95
        nhijo=randi(np/2); %hijo al azar
        bit=randi(nbits); %bit al azar
        if hijobin(nhijo,bit)==1;
            hijobin(nhijo,bit)=0;
        else
            hijobin(nhijo,bit)=1;
        end
    end
    %Sustitucion generacional
    hijodec=bi2de(hijobin);

    xpadres=[padres; hijodec];
end

plot(yprom);
max(y)



