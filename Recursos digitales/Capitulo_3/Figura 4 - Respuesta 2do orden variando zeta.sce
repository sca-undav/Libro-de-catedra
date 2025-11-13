/*******************************************************************************
* Variación de polos según K en un sistema de 2do orden                        *
* UNDAV - SCA                                                                  *
* Versión 2025                                                                 *
*******************************************************************************/

// Definimos nuestra funcion de transferencia **********************************

s=%s
wn=1;
zeta=0.5;
G = wn**2 / (s**2+s*2*zeta*wn+wn**2); 

disp("Transferencia G:")
disp(G)

disp("Polos de la planta G:")
polosPlanta=roots(G.den)
disp(polosPlanta)

// Gráficos para ploteo ********************************************************

close()
close()

figure(1) // Figura de los polos
xgrid();
title('Polos del sistema variando zeta')
xlabel('Eje real (Re)','FontSize',2)
ylabel('Eje imaginario (Im)','FontSize',2)

figure(2) // Figura de las respuestas en el tiempo
xgrid();
title('Respuesta al escalón unitario para sistema de 2do orden variando zeta')
xlabel('wn*t','FontSize',2)
ylabel('Respuesta','FontSize',2)

// Ciclo for-end para múltiples simulaciones ***********************************

intervalo = 14
tiempo=(0:0.0005:1)*intervalo;

for zeta=[0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 1, 1.5, 2]
    G = wn**2 / (s**2+s*2*zeta*wn+wn**2); 
    
    // Polos de la planta ------------------------------------------------------
    polosPlanta=roots(G.den)
    scf(1)
    if polosPlanta~=[] then 
        //Ploteo solo si existe un vector de polos no nulos.
        plot(real(polosPlanta),imag(polosPlanta),'Xb') 
        xstring(real(polosPlanta(1)),imag(polosPlanta(1)),string(zeta))
    end

    // Simulamos en el tiempo para un zeta específico --------------------------
    scf(2)
    G=syslin("c",G)
    y=csim("step",tiempo,G)
    plot(tiempo,y)
    
    // Marcamos valor de zeta en el gráfico ------------------------------------
    [m,k]=max(y); 
    k=min (k,500);
    xstring(tiempo(k), y(k), string(zeta));

end

