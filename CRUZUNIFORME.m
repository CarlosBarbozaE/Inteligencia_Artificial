clear all; %borrar todas las variables
close all; %cerrar todas las ventanas
clc; %limpia la pantalla

xmin= 0;
xmax= 100;
tpaso = 0.1;
elementos= ((xmax-xmin)/tpaso)+1;
nbits= ceil(log2(elementos));
np= 32;

x1=randi([0,2^nbits-1],np,1);
x1real= (xmax-xmin)*x1/(2^nbits-1)+xmin; %convierte enteros a reales

for i=1:50
        y=- (x1real+41.125).^2+200;
        yprom(i)=mean(y);

        cromosoma= sortrows([y x1 x1real],1);

        padresbin= de2bi(cromosoma(np/2+1:np,2),nbits);


    %Encontrar el cruzamiento
    %Cruce uniforme
    
    for k=1 : (np/4)
        mascara=randi([0,1],1,nbits);
        for r=1 : nbits

            if mascara(r)==0
                hijobin(k,:)= [padresbin(2*k-1,1)];

            else
                hijobin(k,:)= [padresbin(2*k,1)];

            end  
        end
    end

        %Mutacion
    p=rand();
    if p>0.95
        nhijo=randi(np/2); %hijo al azar
        bit=randi(nbits); %bit al azar
        if hijobin(nhijo,bit)==1;
            hijo(nhijo,bit)=0;
        else
            hijobin(nhijo,bit)=1;
        end
    end
    %Sustitucion generacional
        hijoent=bi2de(hijobin);
        hijoreal=(xmax-xmin)*hijoent/(2^nbits-1)+xmin;

        x1= [cromosoma(np/2+1:np,2);hijoent]; %Actualizacion de x1
        x1real= [cromosoma(np/2+1:np,3);hijoreal]; %Actualizacion de x1real
end
plot(yprom);
y=- (x1real+41.125).^2+200;
cromosoma= [y x1 x1real];
[val,ind]=max(y)

disp(['Resultado: x1= ' num2str(cromosoma(ind,3)) ', y= ' num2str(val)])