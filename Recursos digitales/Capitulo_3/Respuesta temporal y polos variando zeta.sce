/**********************************************************************
* Respuesta temporal y variación de polos variando zeta
* UNDAV - SCA
**********************************************************************/

// Definimos nuestra funcion de transferencia *************************
s=%s
wn=1;
zeta=0.5;
G = wn**2 / (s**2+s*2*zeta*wn+wn**2); 

disp("Transferencia G:")
disp(G)

disp("Polos de la planta G:")
polosPlanta=roots(G.den)
disp(polosPlanta)

// Gráficos para ploteo ***********************************************
close()
close()
figure(1)  // Figura para polos
clf()
hf=gcf()
hf.background = -2; // Establece fondo blanco
ha=gca()
bound=4
ha.data_bounds = [-bound,-bound;bound,bound];
xgrid();
xlabel('Eje real (Re)','FontSize',2)
ylabel('Eje imaginario (Im)','FontSize',2)
figure(2)  // Figura para respuesta temporal
hf=gcf()
hf.background = -2;
ha=gca()
ha.data_bounds = [0,0;14,1.8];
xgrid();

// CICLO FOR-END PARA MULTIPLES SIMULACIONES **************************
for zeta=[0.1, 0.4, 0.7, 1, 2]
    G = wn**2 / (s**2+s*2*zeta*wn+wn**2); 
    
    // Polos de la planta ---------------------------------------------
    polosPlanta=roots(G.den)
    scf(1)
    if polosPlanta~=[] then 
        //Ploteo solo si existe un vector de polos no nulos.
        plot(real(polosPlanta),imag(polosPlanta),'Xr') 
        //Ploteo de Polos
    end

    // Simulamos en el tiempo para un K específico --------------------
    intervalo = 14
    tiempo=(0:0.0005:1)*intervalo;
    scf(2)
    G=syslin("c",G)
    y=csim("step",tiempo,G)
    plot(tiempo,y)
    
    [m,k]=max(y);
    k=min (k,500);
    xstring(tiempo(k), y(k), string(zeta));

end

