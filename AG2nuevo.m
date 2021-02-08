clear all; %borrar todas las variables
close all; %cerrar todas las ventanas
clc; %limpia la pantalla

xmin1= 0;
xmax1= 3;

xmin2= 0;
xmax2= 3;
tpaso = 1;
elementos1= ((xmax1-xmin1)/tpaso)+1;
elementos2= ((xmax2-xmin2)/tpaso)+1;

nbits= ceil(log2(elementos1));

np= 32;

x1=randi([0,2^nbits-1],np,1);

x1real= (xmax1-xmin1)*x1/(2^nbits-1)+xmin1;

a=-1000;

for i=1:1000
        y=-(x1real-628).^2+20;
        yprom(i)=mean(y);

        cromosoma= sortrows([y x1 x1real],1);
        %Torneo
        for i = 1 : np/2
            moneda = rand()
            if moneda > 0.20
                padre(i,1) = cromosoma(2*i,2)
            else
                padre(i,1) = cromosoma(2*i-1,2)
            end
        end
        padresbin= de2bi(padre,nbits);

        %Cruzamiento triple
        for i = np/2
            n1 = randi([1 np/2]);
            n2 = randi([1 np/2]);
            n3 = randi([1 np/2]);

            p1 = padresbin(n1,:);
            p2 = padresbin(n2,:);
            p3 = padresbin(n3,:);

            c1 = randi([2 nbits-2]);
            c2 = randi([c1+1 nbits-1]);

            hijobin(i,:) = [p1(1,1:c1) p2(1,c1+1:c2) p3(1,c2+1:nbits)];
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
        
        x2= [cromosoma(np/2+1:np,2);hijoent2]; %Actualizacion de x1
        x2real= [cromosoma(np/2+1:np,3);hijoreal2];
end
plot(yprom);
y=-3*x1real+5*x2real;
cromosoma= [y x1 x1real x2 x2real];
[val,ind]=max(y)

disp(['Resultado: x1= ' num2str(cromosoma(ind,3)) ' x2= ' num2str(cromosoma(ind,5)) ' y= ' num2str(val)])