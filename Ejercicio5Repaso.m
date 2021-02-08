clear all;
close all;
clc;

np = 100;
x1p = rand(np, 1);
x1pg = 0;
x1pl = x1p;
x2p = rand(np, 1);
x2pg = 0;
x2pl = x2p;
fxpg = 1000;
fxpl = ones(np, 1)*fxpg;
vx1 = zeros(np, 1);
vx2 = zeros(np, 1);
c1 = 0.5;
c2 = 0.5;
a = 1000;
for d = 1:100
    %Parte iterativa
    %Evaluacion
    fx = -(sin(3*x1p)+cos(3*x2p)+sin(x1pl+x2p))+a*max((x1p.^2)-10*x2p+1,0)+...
        a*max(10*x1p+(x2p.^2)-100,0)+a*max(x1p-1,0)+a*max(x2p-1,0);
    [val, ind] = min(fx);
    if val < fxpg
        fxpg = val;
        x1pg = x1p(ind, 1);
        x2pg = x2p(ind, 1);
    end

    for p = 1:np
        if fx(p, 1) < fxpl(p, 1)
            fxpl(p, 1) = fx(p, 1);
            x1pl(p, 1) = x1p(p, 1);
            x2pl(p, 1) = x2p(p, 1);
        end
    end

    plot(x1p,x2p,'b.',0,0,'rx',x1pg,x2pg,'go');
    axis([0 5 0 5]);
    title(['x1pg= ' num2str(x1pg) ' x2pg= ' num2str(x2pg)]);
    pause(0.1);

    vx1 = vx1 + c1*rand()*(x1pl-x1p) + c2*rand()*(x1pg-x1p);
    vx2 = vx2 + c1*rand()*(x2pl-x2p) + c2*rand()*(x2pg-x2p);
    x1p = vx1 + x1p;
    x2p = vx2 + x2p;
end

y = sin(3*x1p)+cos(3*x2p)+sin(x1pl+x2p);
