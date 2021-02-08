clear all; %Limpiar variables
close all; %Cerrar ventanas
clc; %Limpiar pantalla

xmin1=-5.12; %l�mite inferior
xmax1=5.12; %l�mite superior

xmin2=-5.12; %l�mite inferior
xmax2=5.12; %l�mite superior


tpaso1=0.01; %tama�o de paso
tpaso2=0.01;

elementos1=(xmax1-xmin1)/tpaso1+1; %Cantidad de n�meros
elementos2=(xmax2-xmin2)/tpaso2+1;

nbits1=ceil(log2(elementos1)); %Cantidad de bits
nbits2=ceil(log2(elementos2));

% Generar a la poblaci�n inicial
np=512; %n�mero de pobladores

x1=randi([0,2^nbits1-1],np,1); % Padres enteros
x2=randi([0,2^nbits2-1],np,1);

x1real=(xmax1-xmin1)*x1/(2^nbits1-1)+xmin1; %Convierte enteros a Reales
x2real=(xmax2-xmin2)*x2/(2^nbits2-1)+xmin2;

for i=1:1000
   
    y=-(20+x1real.^2+x2real.^2-10*cos(2*pi*x1real)-10*cos(2*pi*x2real));  %Funci�n objetivo
    yprom(i)=mean(y);  %Desempe�o promedio
    
    cromosoma=sortrows([y x1 x1real x2 x2real],1); %Informaci�n gen�tica

    %Selecci�n
    padresbin1=de2bi(cromosoma(np/2+1:np,2),nbits1); %Se toman los enteros para 
    %convertir en binario
    padresbin2=de2bi(cromosoma(np/2+1:np,4),nbits2);

    %Cruzamiento 

   for k=1:(np/4)
            n=randi([2,nbits1-1]); %Punto de cruce aleatorio
            hijobin1(2*k-1,:)=[padresbin1(2*k-1,1:n) padresbin1(2*k,n+1:nbits1)];%Hijo1
            hijobin1(2*k,:)=[padresbin1(2*k,1:n) padresbin1(2*k-1,n+1:nbits1)]; %Hijo2
            
            n=randi([2,nbits2-1]); %Punto de cruce aleatorio
            hijobin2(2*k-1,:)=[padresbin2(2*k-1,1:n) padresbin2(2*k,n+1:nbits2)];%Hijo1
            hijobin2(2*k,:)=[padresbin2(2*k,1:n) padresbin2(2*k-1,n+1:nbits2)]; %Hijo2
    end 

    %Mutaci�n 
     %Mutaci�n
        p=rand();
        if p>0.90  % o p<0.10  10% de probabilidad
            nhijo=randi(np/2); %hijo al azar
            bit=randi(nbits1); %bit al azar
            if hijobin1(nhijo,bit)==1
                hijobin1(nhijo,bit)=0;
            else
                hijobin1(nhijo,bit)=1;
            end
        end

    p=rand();

        if p>0.90  % o p<0.10  10% de probabilidad
            nhijo=randi(np/2); %hijo al azar
            bit=randi(nbits2); %bit al azar
            if hijobin2(nhijo,bit)==1
                hijobin2(nhijo,bit)=0;
            else
                hijobin2(nhijo,bit)=1;
            end
        end

      %Sustituir a la poblaci�n
      hijoent1=bi2de(hijobin1);
      hijoreal1=(xmax1-xmin1)*hijoent1/(2^nbits1-1)+xmin1;

      hijoent2=bi2de(hijobin2);
      hijoreal2=(xmax2-xmin2)*hijoent2/(2^nbits2-1)+xmin2;
      
      x1=[cromosoma(np/2+1:np,2);hijoent1]; %Actualizaci�n de enteros
      x1real=[cromosoma(np/2+1:np,3);hijoreal1]; %Actualizaci�n de Reales
      
      x2=[cromosoma(np/2+1:np,4);hijoent2]; %Actualizaci�n de enteros
      x2real=[cromosoma(np/2+1:np,5);hijoreal2]; %Actualizaci�n de Reales

end  

plot(yprom);
 y=-(20+x1real.^2+x2real.^2-10*cos(2*pi*x1real)-10*cos(2*pi*x2real)); 
cromosoma=[y x1 x1real x2 x2real];

[val,ind]=max(y);

disp(['Resultado: x1= ' num2str(cromosoma(ind,3)) ...
     ' x2= ' num2str(cromosoma(ind,5)) '  y= ' num2str(val)])







