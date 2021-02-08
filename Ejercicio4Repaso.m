clear all;
close all;
clc;

np = 500;
x1p = rand(np, 1)+175;
x1pg = 0;
x1pl = x1p;
x2p = rand(np, 1)+5;
x2pg = 0;
x2pl = x2p;
x3p = rand(np, 1)+101;
x3pg = 0;
x3pl = x3p;

fxpg = 100000;
fxpl = ones(np, 1)*fxpg;
vx1 = zeros(np, 1);
vx2 = zeros(np, 1);
vx3 = zeros(np, 1);
c1 = 0.5;
c2 = 0.5;

a = 1000;
for d = 1:2000
    %Parte iterativa
    %Evaluacion
    fx = x1p+x2p+x3p+a*max(-x1p,0)+a*max(-x2p,0)+a*max(-x3p,0)+...
        a*max(400-2*x1p-x2p-0.5*x3p,0)+a*max(100-0.5*x1p-0.5*x2p-x3p-(2*x1p+x2p+0.5*x3p-400),0)+...
        a*max(300-1.5*x2p-2*x3p+100*0.5*x1p-0.5*x2p-x3p-(2*x1p+x2p+0.5*x3p-400),0);
    [val, ind] = min(fx);
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
fx = x1p+x2p+x3p;
x1p
x2p
x3p