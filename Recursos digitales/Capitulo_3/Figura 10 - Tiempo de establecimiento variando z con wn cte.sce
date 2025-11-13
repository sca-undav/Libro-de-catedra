/******************************************************************************
* Tiempo de establecimiento
* -----------------------------------------------------------------------------
* Archivo:   Tiempo de establecimiento...
* Breve:     Variamos zeta para wn constante.
*            Simulamos para márgenes de 1%, 5% y 10%
* Contacto:  gfcaporaletti@undav.edu.ar
* Fecha:     Septiembre 2024
******************************************************************************/

// Módulo externo -------------------------------------------------------------
exec("sca-soporte.sci",-1)

/*****************************************************************************/

// Configuración gráfica ------------------------------------------------------
close()
close()
figure(1)
xgrid()
plotFondoBlanco()

figure(2)
xgrid()
plotFondoBlanco()
title("Tiempo de establecimiento segun z para wn constante")
xlabel('zeta','FontSize',2)
ylabel('wn*te','FontSize',2)

// Configuración para simulaciones --------------------------------------------
muestras_tiempo = 500;
tiempo_maximo = 31;
delta_tiempo = tiempo_maximo / (muestras_tiempo-1);
tiempo=0:delta_tiempo:tiempo_maximo;
wn=1
z=union(0.05:0.001:0.85,0.85:0.005:1.4)
muestras_z=length(z)
TiempoEstablecimiento01=zeros(1,muestras_z)
TiempoEstablecimiento05=zeros(1,muestras_z)
TiempoEstablecimiento10=zeros(1,muestras_z)
TSA5=zeros(1,muestras_z)
Color=["r","g","b","k"]

// Ciclo principal ------------------------------------------------------------
for m=1:muestras_z
    T=wn**2/(%s**2+2*z(m)*wn*%s+wn**2)
    T=syslin('c',T)

    // TSA5(m) = TiempoEstablecimientoAproximado(z(m),wn)
    tiempo_maximo = min (5*(1/z(m)+z(m)^2), 31) // Límite superior hasta z=1.4
    delta_tiempo = tiempo_maximo / (muestras_tiempo-1);
    tiempo=0:delta_tiempo:tiempo_maximo;
    
    y=csim('step',tiempo,T);
    scf(1)
    plot(tiempo,y);  
    TiempoEstablecimiento01(m)=TiempoEstablecimiento(y, tiempo, 1, 0.01)
    TiempoEstablecimiento05(m)=TiempoEstablecimiento(y, tiempo, 1, 0.05)
    TiempoEstablecimiento10(m)=TiempoEstablecimiento(y, tiempo, 1, 0.10)    
end

// Resultado del tiempo de crecimiento ----------------------------------------
scf(2)
plot(z,TiempoEstablecimiento01,z,TiempoEstablecimiento05,z,TiempoEstablecimiento10)
//plot(z,TSA5, "g--")
final=muestras_z*0.94
xstring(z(final),TiempoEstablecimiento10(final),"10%")
xstring(z(final),TiempoEstablecimiento05(final),"5%")
xstring(z(final),TiempoEstablecimiento01(final),"1%")
plotLimites(0,0,1.4,30)
    
