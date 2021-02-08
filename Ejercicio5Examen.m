clear all; %borrar todas las variables
close all; %cerrar todas las ventanas
clc; %limpia la pantalla

np = 1000;
nproductos = 3;

xp = rand(np,nproductos).*randi([0 200], np,nproductos);
xpg = zeros(1,nproductos);
xpl = xp;

fxpg = 1000000;

fxpl = ones(np,1)*fxpg;

vx = zeros(np,nproductos);

c1 = 0.5;
c2 = 0.5;

a = -1000;


for k = 1:100
    
    fx = (xp(:,1)*4+xp(:,2)*12+xp(:,3)*2)+a*(max(xp(:,1)*3+xp(:,2)*6+xp(:,3)*2-600,0)+...
        max(xp(:,1)+xp(:,2)+xp(:,3)-240,0)+max(140-xp(:,3),0)+ max(xp(:,2)-1,0));
    
    [val,ind] = min(fx);
    if val<fxpg
        fxpg = val;
        
        for c = 1:nproductos
            xpg(:,c) = xp(ind,c);
        end
    end
    
    for p = 1:np
        if fx(p,1)<fxpl(p,1)
            fxpl(p,1) = fx(p,1);
            
            for c = 1:nproductos
                xpl(p,c) = xp(p,c);
            end
        end
    end
    
    plot(xp(:,1),xp(:,2),'b.',xp(:,1),xp(:,3),'r.',xp(:,2),xp(:,3),'g.');
    axis([0 200 0 200]);
    title(['x1pg= ' num2str(xpg(:,1)) 'x2pg= ' num2str(xpg(:,2)) 'x2pg= ' num2str(xpg(:,3))]);
    pause(0.1);
    
    for d = 1:nproductos
        vx(:,d) = vx(:,d) + c1*rand()*(xpl(:,d)-xp(:,d)) + c2*rand()*(xpg(:,d)-xp(:,d));
    end
    
    for d = 1:nproductos
        xp(:,d) = vx(:,d);
    end
end

fx = sum(xpg);
fprintf('la cantidad minima por invertir es de %d millones, invirtiendo %d millones en el Activo1, %d millones en el Activo2 y %d millones en el Activo3.'...
    ,round(fx),round(xpg))
