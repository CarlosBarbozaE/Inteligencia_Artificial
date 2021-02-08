%Red neuronal Competitiva
clear all;
close all;
clc;

%Carga de datos
data=xlsread('buddymove_holidayiq.xls','buddymove_holidayiq','B1:G249');
data=data';

%% Creación del modelo Neuronal

nn=4; %Número de Neuronas

red=competlayer(nn); %Red neuronal de tipo competitiva. Crea la red
red.trainParam.epochs=100; % Modificar épocas
red=train(red,data); %Entrenamiento de la red

Wf = red.IW{1,1}'; %Pesos finales

%Separar datos por cada grupo
Y=red(data); %Simula los datos en el modelo
Y=vec2ind(Y);  %convierte de vectores a indices
grupos=unique(Y);  %Números sin repeticiones

for k=1:size(grupos,2)
    temp=data(:,Y==grupos(1,k));
    eval(sprintf('grupo%d=temp;',k));
end

%Calculo de J
J=0; %se le da un valor inicial a la J
for num=1:size(grupos,2)' %va a hacer esto con cada grupo
    size1 = eval(sprintf('size(grupo%d,2)',num));
    for c=1:size1
        eval(sprintf('H%d(c,1)=norm(grupo%d(:,c)-Wf(:,num))',num,num)); %normas de diferencias del grupo
    end
    eval(sprintf('J%d=sum(H%d)/size(grupo%d,2);',num,num,num)); %sumatoria del grupo dividida
    J = J + eval(sprintf('J%d',num)); %suma las J
end
Jmodelo = J/size(grupos,2)'; %promedio de J

data2 = [18 69 82 113 84 213; 8 15 94 57 54 108; 30];
datosclas = data2';
Yclas = red(datosclas);
Yclas = vec2ind(Yclas) 

