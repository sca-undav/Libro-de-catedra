/***********************************************************************
* Respuesta a un escalón
* SCA, UNDAV
***********************************************************************/

/**** Variables locales ***********************************************/
s=%s;
Constante = 2; 
Tau = 50; // en segundos pero puede ser otra unidad
G = Constante / (s*Tau + 1);

printf("\nTransferencia G:")
disp(G)
printf("\nTau = %.1f\n", Tau);

/**** Programa principal **********************************************/

// Configuramos figuras para plotear -----------------------------------
close()
figure(1)
title("Respuesta a un escalón")
xlabel('Tiempo','FontSize',2)
ylabel('Salida','FontSize',2)

// Simulación ----------------------------------------------------------
tiempo=0:0.1:500
G=syslin("c",G);
y=csim("step",tiempo,G);
plot(tiempo, y);

