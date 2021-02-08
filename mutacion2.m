clear all; %Limpiar variables
close all; %Cerrar ventanas
clc; %Limpiar pantalla

xmin=-100; %límite inferior
xmax=100; %límite superior

tpaso=0.01; %tamaño de paso

elementos=(xmax-xmin)/tpaso+1; %Cantidad de números

nbits=ceil(log2(elementos)); %Cantidad de bits


% Generar a la población inicial
np=512; %número de pobladores

x1=randi([0,2^nbits-1],np,1); % Padres enteros

x1real=(xmax-xmin)*x1/(2^nbits-1)+xmin; %Convierte enteros a Reales

for i=1:1000
   
    y=-(x1real+41.125).^2+200;  %Función objetivo
    yprom(i)=mean(y);  %Desempeño promedio
    
    cromosoma=sortrows([y x1 x1real],1); %Información genética

    %Selección
    padresbin=de2bi(cromosoma(np/2+1:np,2),nbits); %Se toman los enteros para 
    %convertir en binario

    %Cruzamiento 

   for k=1:(np/4)
            n=randi([2,nbits-1]); %Punto de cruce aleatorio
            hijobin(2*k-1,:)=[padresbin(2*k-1,1:n) padresbin(2*k,n+1:nbits)];%Hijo1
            hijobin(2*k,:)=[padresbin(2*k,1:n) padresbin(2*k-1,n+1:nbits)]; %Hijo2
    end 

    %Mutación 
     %Mutación
        p=rand();
        if p>0.90  % o p<0.10  10% de probabilidad
            nhijo=randi(np/2); %hijo al azar
            bit=randi(nbits); %bit al azar
            if hijobin(nhijo,bit)==1
                hijobin(nhijo,bit)=0;
            else
                hijobin(nhijo,bit)=1;
            end
        end


      %Sustituir a la población
      hijoent=bi2de(hijobin);
      hijoreal=(xmax-xmin)*hijoent/(2^nbits-1)+xmin;

      x1=[cromosoma(np/2+1:np,2);hijoent]; %Actualización de enteros
      x1real=[cromosoma(np/2+1:np,3);hijoreal]; %Actualización de Reales
end  

plot(yprom);
y=-(x1real+41.125).^2+200;
cromosoma=[y x1 x1real];

[val,ind]=max(y);

disp(['Resultado: x1= ' num2str(cromosoma(ind,3)) '  y= ' num2str(val)])







