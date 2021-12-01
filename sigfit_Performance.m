
%This code fit an error function between the firing rate and the linear
%estimation of the firing rate for multiple neurons
%xdata is a matrix containing the actual firing rate of each neuron 
%dmaxdata is a matrix containing the linear estimation of the  firing rate of each neuron

RNL=[];
NLVAF=[];
for i=1:length(xdata(:,1));


%--- Curve fitting Dmax ---%

%--- Starting guess = nombre d'inconnu dans l'équation voir sigfit.m ---%

  x0 = [10, 10, 10];  
  

%--- Fonction d'optimisation pour le curve fitting ---%

 [x,resnorm] = lsqcurvefit(@sigfit,x0,xdata,dmaxdata);

%--- construction de la courbe optimisée pour visualisation ---%

Y1 = x(1)/2*(1+erf((xdata-x(2))/(sqrt(2)*x(3))));           %Estimation

%--- Graphique curve fitting ---%

figure,plot(xdata,Y1,'o'),hold on, plot(xdata, dmaxdata,'og');


%--- Performance du fitting ---%

ssr = sum(abs(Y1-mean(dmaxdata)).^2);

%--- Sum of squared of error ---%

sse = sum(abs(Y1-dmaxdata).^2);

%--- Pearson's coefficient ---%

r = sqrt(ssr/(sse+ssr));


%--- Variance explained by the model ---%

R = r^2;

xF=[xF; x];

RNL=[RNL; R];
NLvaf = 1 - (var(dmaxdata - Y1)/var(dmaxdata));
NLVAF=[NLVAF;NLvaf];
end
