clear all;
close all;
clc;

np = 1000;
x1p = randi([0 100],np, 1);
x1pg = 0;
x1pl = x1p;
x2p = randi([0 100],np, 1);
x2pg = 0;
x2pl = x2p;
x3p = rand(np, 1);
x3pg = 0;
x3pl = x3p;
fxpg = 100000;
fxpl = ones(np, 1)*fxpg;
vx1 = zeros(np, 1);
vx2 = zeros(np, 1);
vx3 = zeros(np, 1);
c1 = 0.5;
c2 = 0.5;
a = -1000;
for d = 1:1000
    %Parte iterativa
    %Evaluacion
    fx = ((20*x1p+10*x2p+25*x3p)+a*max(120-x1p-x2p-x3p,0)+...
        a*max(3*x1p+x2p+x3p-273,0)+a*max(-355+x1p+2*x2p+5*x3p,0)+...
        a*max(-x1p,0)+a*max(-x2p,0)+a*max(-x3p,0));
    [val, ind] = max(fx);
    if val < fxpg
        fxpg = val;
        x1pg = x1p(ind, 1);
        x2pg = x2p(ind, 1);
        x3pg = x3p(ind, 1);
    end

    for p = 1:np
        if fx(p, 1) < fxpl(p, 1)
            fxpl(p, 1) = fx(p, 1);
            x1pl(p, 1) = x1p(p, 1);
            x2pl(p, 1) = x2p(p, 1);
            x3pl(p, 1) = x3p(p, 1);
        end
    end


    vx1 = vx1 + c1*rand()*(x1pl-x1p) + c2*rand()*(x1pg-x1p);
    vx2 = vx2 + c1*rand()*(x2pl-x2p) + c2*rand()*(x2pg-x2p);
    vx3 = vx3 + c1*rand()*(x3pl-x3p) + c2*rand()*(x3pg-x3p);
    x1p = vx1 + x1p;
    x2p = vx2 + x2p;
    x3p = vx3 + x3p;
end

y = (20*x1pg+10*x2pg+25*x3pg)
x1pg, x2pg, x3pg
