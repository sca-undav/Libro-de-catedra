// Gráfico de la Figura 7

// Variables locales
zeta = 0:0.01:0.99;
sobrevalor = zeros(1,length(zeta));

// Cálculo del sobrevalor para cada valor de zeta
for i=1:length(zeta)
    sobrevalor(i) = 100*exp(-%pi*zeta(i)/sqrt(1-zeta(i)^2));
end

// Ploteo
close();
plot(zeta,sobrevalor);
xlabel('Factor de amortiguamiento relativo','FontSize',2)
ylabel('Porcentaje de sobrevalor [%]','FontSize',2)
xgrid(2);
