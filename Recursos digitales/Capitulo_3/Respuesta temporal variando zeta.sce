/**********************************************************************
* Respuesta temporal de un sistema de 2do orden variando zeta
* UNDAV - SCA
**********************************************************************/

// Definimos una funcion de transferencia *****************************
s=%s
wn=1;
zeta=0.5;  // valor de zeta arbitrario
G = wn**2 / (s**2+s*2*zeta*wn+wn**2); 

disp("Transferencia G:")
disp(G)

disp("Polos de la planta G:")
polosPlanta=roots(G.den)
disp(polosPlanta)

// Gráfico para ploteo ************************************************
close()
figure(1)
hf=gcf()
hf.background = -2;
ha=gca()
ha.data_bounds = [0,0;14,1.8];
xgrid();

// Ciclo for-end para múltiples simulaciones **************************
intervalo = 14
tiempo=(0:0.0005:1)*intervalo;
for zeta=[0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 1, 1.5, 2]
    G = wn**2 / (s**2+s*2*zeta*wn+wn**2); 
    G = syslin("c",G)          // Definimos sistema lineal y continuo
    y = csim("step",tiempo,G)  // Simulamos en el tiempo
    plot(tiempo,y)             // Graficamos
    [m,k]=max(y);              // Obtenemos valor máximo y muestra
    k=min (k,500);
    xstring(tiempo(k), y(k), string(zeta));
end

