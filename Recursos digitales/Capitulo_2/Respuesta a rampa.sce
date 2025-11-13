/***********************************************************************
* Respuesta a una rampa
* SCA, UNDAV
* 2025
***********************************************************************/

// Limpio figuras previas **********************************************
clear;   // Borramos todas las variables
close(); // Borramos figura actual

// Defino parámetros de la planta y de simulación **********************
Tau=1
tsim=5*Tau
dt=0.005*tsim
t=0:dt:tsim; 
s=poly(0,'s')  // Define variable s
G1=syslin('c', 1/(1+Tau*s))  // Función de transferencia de la planta
deff('u=timefun(t)','u=t')   // Definimos la función rampa unitaria

// Simulación **********************************************************
/* Para realizar la simulacion se utiliza la funcion csim(). 
   El contenido y orden del argumento de esta función es:
   - Señal de entrada de prueba
   - Vector de tiempo
   - Funcion de transferencia a simular */
A=csim(timefun,t,G1);

// Graficamos **********************************************************
figure(1,"backgroundcolor",[1 1 1]);
title('Respuesta a una rampa unitaria')
xlabel('Tiempo');
plot(t,timefun,'r');
plot(t,A,'b');

// Asíntota
t2=t(ceil(Tau/dt+1):(tsim/dt+1));   // intervalo de tiempo 2
asintota=t2-Tau; 
plot(t2,asintota,'k--');


