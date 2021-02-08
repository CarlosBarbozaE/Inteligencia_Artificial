clear all; %borrar todas las variables
close all; %cerrar todas las ventanas
clc; %limpia la pantalla

xmin1= 0;
xmax1= 4;

xmin2= 0;
xmax2= 6;

tpaso1 = 0.01;
tpaso2 = 0.01;

elementos1= ((xmax1-xmin1)/tpaso1)+1;
elementos2= ((xmax2-xmin2)/tpaso2)+1;

nbits1= ceil(log2(elementos1));
nbits2= ceil(log2(elementos2));
np= 512;

x1=randi([0,2^nbits1-1],np,1);
x2=randi([0,2^nbits2-1],np,1);

x1real= (xmax1-xmin1)*x1/(2^nbits1-1)+xmin1;
x2real= (xmax2-xmin2)*x2/(2^nbits2-1)+xmin2;%convierte enteros a reales

a=-1000;
for i=1:1000
        y=3*x1real+2*x2real+a*max(3*x1real+2*x2real-18,0);
        yprom(i)=mean(y);

        cromosoma= sortrows([y x1 x1real x2 x2real ],1);

        padresbin1= de2bi(cromosoma(np/2+1:np,2),nbits1);
        padresbin2= de2bi(cromosoma(np/2+1:np,4),nbits2);


        for k=1 : (np/4)
                n=randi([2,nbits1-1]); %Punto de cruce aleatorio
                hijobin1(2*k-1,:)= [padresbin1(2*k-1,1:n) padresbin1(2*k,n+1:nbits1)];
                hijobin1(2*k,:)= [padresbin1(2*k,1:n) padresbin1(2*k-1,n+1:nbits1)];
                
                n=randi([2,nbits2-1]); %Punto de cruce aleatorio
                hijobin2(2*k-1,:)= [padresbin2(2*k-1,1:n) padresbin2(2*k,n+1:nbits2)];
                hijobin2(2*k,:)= [padresbin2(2*k,1:n) padresbin2(2*k-1,n+1:nbits2)];
                
               
        end

        %Mutacion
        p=rand();
        if p>0.90
            nhijo1=randi(np/2); %hijo al azar
            bit1=randi(nbits1); %bit al azar
            if hijobin1(nhijo1,bit1)==1;
                hijobin1(nhijo1,bit1)=0;
            else
                hijobin1(nhijo1,bit1)=1;
            end
        end
        
        p=rand();
        if p>0.95
            nhijo2=randi(np/2); %hijo al azar
            bit2=randi(nbits2); %bit al azar
            if hijobin2(nhijo2,bit2)==1;
                hijobin2(nhijo2,bit2)=0;
            else
                hijobin2(nhijo2,bit2)=1;
            end
        end
        
        
        %Sustitucion generacional
        hijoent1=bi2de(hijobin1);
        hijoreal1=(xmax1-xmin1)*hijoent1/(2^nbits1-1)+xmin1;
        
        hijoent2=bi2de(hijobin2);
        hijoreal2=(xmax2-xmin2)*hijoent2/(2^nbits2-1)+xmin2;
        
       
        x1= [cromosoma(np/2+1:np,2);hijoent1]; %Actualizacion de x1
        x1real= [cromosoma(np/2+1:np,3);hijoreal1]; %Actualizacion de x1real
        
        x2= [cromosoma(np/2+1:np,4);hijoent2]; %Actualizacion de x1
        x2real= [cromosoma(np/2+1:np,5);hijoreal2];
        
        
end
plot(yprom);
y=3*x1real+2*x2real;
cromosoma= [y x1 x1real x2 x2real];
[val,ind]=max(y)

disp(['Resultado: x1= ' num2str(cromosoma(ind,3)) ' x2= ' num2str(cromosoma(ind,5)) ])