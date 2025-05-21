/***********************************************************************
* Control proporcional variando Kp
* SCA, UNDAV
* 2025
***********************************************************************/

/**** Funciones locales ***********************************************/
function figura_fondo_blanco()
// Establece un fondo blanco para la figura actual
    hf=gcf();           // "get current figure"
    hf.background = -2; // Color blanco
endfunction

function figura_limites(x1, y1, x2, y2)
// Establece límites a la figura actual
    ha=gca();           // "get current axis"
    ha.data_bounds = [x1, y1; x2, y2];
    ha.auto_scale = "off"; 
endfunction

/**** Variables locales ***********************************************/
s=%s;
Constante = 3; 
Tau = 250; // en segundos pero puede ser otra unidad
G = Constante / (s*Tau + 1);
Objetivo = 100;

printf("\nTransferencia G:")
disp(G)
printf("\nObjetivo = %.1f\n", Objetivo)

cerosPlanta=roots(G.num)
polosPlanta=roots(G.den)
disp("Polos de la planta G:")
disp(polosPlanta)

/**** Programa principal **********************************************/

// Configuramos figuras para plotear ----------------------------------
close()
close()

figure(1)  // Salida en función del tiempo y variando Kp
//figura_fondo_blanco()
title("Respuesta a un escalón variando Kp")
xlabel('Tiempo','FontSize',2)
ylabel('Variable controlada','FontSize',2)

figure(2)  // Acción de control
//figura_fondo_blanco()
title("Polos del sistema variando Kp")
xlabel('Eje real (Re)','FontSize',2)
ylabel('Eje imaginario (Im)','FontSize',2)
limite = 1
//figura_limites(limite,limite,limite,limite)

// Lazo cerrado variando K --------------------------------------------

tiempo=0:0.1:500
i=0
Color = ["b-", "m-", "r-", "y-", "g-", "c-"]
ColorX = ["bx", "mx", "rx", "yx", "gx", "cx"]
for Kp=[0.5, 1, 2, 5, 10, 25]
    // Establecemos indice de formato/color
    i=i+1
    if i>size(Color)(2) then i=1; end
        
    // Transferencias global
    M=Kp*G/(1+Kp*G)
    
    // Grafico de respuesta en fn del tiempo
    scf(1);
    M=syslin("c",M);
    y=Objetivo*csim("step",tiempo,M);
    plot(tiempo, y, Color(i));

    // Polos del sistema a lazo cerrado
    scf(2)
    cerosM=roots(M.num)
    polosM=roots(M.den)
    if polosLC~=[] then
       plot(real(polosM),imag(polosM),ColorX(i)) 
       xstring(real(polosM),imag(polosM),string(Kp))
    end
    
end
