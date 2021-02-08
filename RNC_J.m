function [Jas]=RNC_J (nn,data) 
% Funcion que da el valor de J para unos datos analizados con redes
% neuronales de nn neuronas.

% Crear Red Neuronal
J=0; %se le da un valor inicial a la J
red=competlayer(nn); %Crear la red neuronal
red.trainParam.epochs=100; %Numero de epocas
red=train(red,data); % Entrenamiento de la red neuronal
Wf=red.IW{1,1}'; %Pesos de los grupos o neuronas
Y=red(data);
Y=vec2ind(Y); %De vectores a índices
grupos=unique(Y); %Vector de los grupos que hay
for k=1:size(grupos,2)
    temp=data(:,Y==grupos(1,k));
    eval(sprintf('grupo%d=temp;',k)); %igual que eval pero lo hace primero el texto y luego el digito
end
for num_group=1:size(grupos,2)' %va a hacer esto con cada grupo
    size_group = eval(sprintf('size(grupo%d,2)',num_group));
    for c=1:size_group
        eval(sprintf('H%d(c,1)=norm(grupo%d(:,c)-Wf(:,num_group))',num_group,num_group)); %normas de diferencias del grupo
    end
    eval(sprintf('J%d=sum(H%d)/size(grupo%d,2);',num_group,num_group,num_group)); %sumatoria del grupo dividida
    J = J + eval(sprintf('J%d',num_group)); %suma las J
end
Jas = J/size(grupos,2)'; %promedio de J