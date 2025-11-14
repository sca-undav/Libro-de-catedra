/***********************************************************************
* Tiempo de crecimiento para wn constante
* ----------------------------------------------------------------------
* Archivo:   Tiempo de crecimiento...
* Breve:     Variamos zeta para wn constante.
*            Simulamos para márgenes de 5%-95%, 10%-90%
* Contacto:  gfcaporaletti@undav.edu.ar
* Fecha:     Septiembre 2024
***********************************************************************/

exec("sca-soporte.sci",-1) // Módulo externo

/* Configuración gráfica **********************************************/

close()
close()
figure(0)
xgrid(1)
plotFondoBlanco() // Función del módulo externo

figure(1)  // Figura para el tiempo de crecimiento segun z
xgrid(1)
plotFondoBlanco()
plotLimites(0,0,1.4,6)  // Función externa que fija límites
title("Tiempo de crecimiento segun amortiguamiento (wn=cte)")
xlabel('Factor de amortiguamiento relativo','FontSize',2)
ylabel('Tiempo de crecimiento por frecuencia natural','FontSize',2)

/* Configuración para simulaciones ************************************/

DeltaT=0.01
t=0:DeltaT:15   // Vector de tiempo
wn=1
z=0:0.025:1.4
muestras_z=length(z)
TiempoCrecimiento1090=zeros(1,muestras_z)

/* Simulación y ploteos ***********************************************/

for m=1:muestras_z
    T=wn**2/(%s**2+2*z(m)*wn*%s+wn**2)
    T=syslin('c',T)
    y=csim('step',t,T)
    scf(0)
    plot(t,y)
    // Función externa que devuelve el índice de lo buscado:
    TiempoCrecimiento1090(m)=(BuscarValor(y,0.90)-BuscarValor(y,0.10))*DeltaT  
end

scf(1)
plot(z,TiempoCrecimiento1090)

// Asíntota
asintota = [0,5.368]
asintota_t = [0.35,1.4]
plot(asintota_t,asintota,"k--")
disp("Asintota: a(t) = (t-0,35)*ka")
disp(5.368/(1.4-0.35))


