close all;
clear all;
clc;

syms x
funciones = [x ;x^2 ;x^3 ;sin(x) ;cos(x) ;sin(x^2) ;cos(x^2) ;sin(x^3) ;cos(x^3) ;(sin(x))^2 ;(cos(x))^2; exp(x); x^4; log(x+.5); log(x+2); x+sin(x)];
yreal = [0 0.00998334 0.03973387 0.08865606 0.15576734 0.23971277 0.33878548 0.45095238 0.57388487 0.70499422 0.84147098];
generaciones = 3;
pobladores = 8;

v = [];
s = [];
for i=1:pobladores   
    r1 = randi([1 16],1,1);
    r2 = randi([1 16],1,1);
    r3 = randi([1 16],1,1);
    e1 = funciones(r1,1);
    e2 = funciones(r2,1);
    e3 = funciones(r3,1);
    vector_ecu = [e1 e2 e3];
    v = [v,vector_ecu];
    suma = sum(vector_ecu,2);
    s = [s,suma];
end

ev = [];
for i=1:pobladores
    f = s(i);
    evalu = subs(f,x,0:0.1:1);
    ev = [ev,evalu];
end

yestim = double(ev);

corr = [];
a = 1;
b = 11;
for i=1:pobladores
    coef = corrcoef(yestim(a:b),yreal);
    corr = [corr,coef(1,2)];
    a = a+11;
    b = b+11;
end

tabla = [s(1) v(1) v(2) v(3) corr(1); s(2) v(4) v(5) v(6) corr(2); 
    s(3) v(7) v(8) v(9) corr(3); s(4) v(10) v(11) v(12) corr(4);
    s(5) v(13) v(14) v(15) corr(5); s(6) v(16) v(17) v(18) corr(6); 
    s(7) v(19) v(20) v(21) corr(7); s(8) v(22) v(23) v(24) corr(8)];

c = 0.5;

for n=1:generaciones
    cromosoma = sortrows(tabla,5, 'descend');
    cromosoma((5:8),:) = [];

    hijo1 = [cromosoma(1,2) cromosoma(1,3) cromosoma(1,4)];
    p=rand();
    if p>c
        alea = randi([1 2],1,1);
        if alea == 1 
            r = randi([1 16],1,1);e = funciones(r,1);
            rale = randi([1 3],1,1);
            hijo1(1, rale) = e;
        else
            rh1 = randi([1 16],1,1);eh1 = funciones(rh1,1);
            rh2 = randi([1 16],1,1);eh2 = funciones(rh2,1);
            rh3 = randi([1 16],1,1);eh3 = funciones(rh3,1);
            hijo1 = [eh1 eh2 eh3];
        end
    end
    suma1 = sum(hijo1);
    evalu1 = subs(suma1,x,0:0.1:1);
    coef1 = corrcoef(evalu1,yreal);
    corr1 = double(coef1(1,2));

    hijo2 = [cromosoma(2,2) cromosoma(2,3) cromosoma(2,4)];
    p=rand();
    if p>c
        alea = randi([1 2],1,1);
        if alea == 1 
            r = randi([1 16],1,1);e = funciones(r,1);
            rale = randi([1 3],1,1);
            hijo2(1, rale) = e;
        else
            rh1 = randi([1 16],1,1);eh1 = funciones(rh1,1);
            rh2 = randi([1 16],1,1);eh2 = funciones(rh2,1);
            rh3 = randi([1 16],1,1);eh3 = funciones(rh3,1);
            hijo2 = [eh1 eh2 eh3];
        end
    end
    suma2 = sum(hijo2);
    evalu2 = subs(suma2,x,0:0.1:1);
    coef2 = corrcoef(evalu2,yreal);
    corr2 = double(coef2(1,2));

    hijo3 = [cromosoma(3,2) cromosoma(3,3) cromosoma(3,4)];
    p=rand();
    if p>c
        alea = randi([1 2],1,1);
        if alea == 1 
            r = randi([1 16],1,1);e = funciones(r,1);
            rale = randi([1 3],1,1);
            hijo3(1, rale) = e;
        else
            rh1 = randi([1 16],1,1);eh1 = funciones(rh1,1);
            rh2 = randi([1 16],1,1);eh2 = funciones(rh2,1);
            rh3 = randi([1 16],1,1);eh3 = funciones(rh3,1);
            hijo3 = [eh1 eh2 eh3];
        end
    end
    suma3 = sum(hijo3);
    evalu3 = subs(suma3,x,0:0.1:1);
    coef3 = corrcoef(evalu3,yreal);
    corr3 = double(coef3(1,2));

    hijo4 = [cromosoma(4,2) cromosoma(4,3) cromosoma(4,4)];
    p=rand();
    if p>c
        alea = randi([1 2],1,1);
        if alea == 1 
            r = randi([1 16],1,1);e = funciones(r,1);
            rale = randi([1 3],1,1);
            hijo4(1, rale) = e;
        else
            rh1 = randi([1 16],1,1);eh1 = funciones(rh1,1);
            rh2 = randi([1 16],1,1);eh2 = funciones(rh2,1);
            rh3 = randi([1 16],1,1);eh3 = funciones(rh3,1);
            hijo4 = [eh1 eh2 eh3];
        end
    end
    suma4 = sum(hijo4);
    evalu4 = subs(suma4,x,0:0.1:1);
    coef4 = corrcoef(evalu4,yreal);
    corr4 = double(coef4(1,2));

    hijos = [suma1 hijo1 corr1; suma2 hijo2 corr2; suma3 hijo3 corr3; suma4 hijo4 corr4];

    tabla = [cromosoma; hijos];
end

%print (tabla);
