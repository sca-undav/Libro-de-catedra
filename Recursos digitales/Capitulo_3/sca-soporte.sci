/******************************************************************************
* Archivo:   sca-soporte.sci
* Breve:     Funciones de sorporte para SCA (UNDAV).
* Contacto:  gfcaporaletti@undav.edu.ar
* Versión:   1.2
* Fecha:     Septiembre 2024.
******************************************************************************/

//*****************************************************************************
function tn=BuscarValor(vector,buscado)
/* Busca "buscado" en el "vector" y devuelve la ubicación 
   en que encontró o pasó por ese valor.                     
*/
tn=-1                // Valor que devuelve si no lo encuentra
largo=length(vector) // Largo del vector
v0=vector(1)         // Valor inicial
if (v0<buscado) then
    pendiente=1      // La señal debe subir para encontrar el valor
else
    pendiente=-1     // La señal debe bajar...
end
for i=1:largo
    if ((vector(i)-buscado)*pendiente)>=0 then
        // Encontramos el valor o la transición
        tn=i;
        break;
    end;
end
endfunction

//*****************************************************************************
function tn=UltimaTransicion(vector,valor)
/* Busca la última vez que el "vector" transiciona o atraviesa el "valor".
   Devuelve esa ubicación.
*/
   tn=-1                // Valor que devuelve si no lo encuentra
   largo=length(vector) // Largo del vector
   if (vector(1)<valor) then
      pendiente=1      // La señal debe subir para encontrar el valor
   else
      pendiente=-1     // La señal debe bajar...
   end
   for i=1:largo
      if ((vector(i)-valor)*pendiente)>=0 then
          // Encontramos el valor o la transición
          tn=i;
          pendiente=-pendiente;
      end;
   end
endfunction

//*****************************************************************************
function ts=TiempoEstablecimiento(vector_senial, vector_tiempo, valor_final, porcentaje)
/* Busca el Tiempo d eEstablecimiento de vector_senial, 
   con vector_tiempo, 
   un valor_final en estado estacionario 
   y para un porcentaje de error admisible.
*/
   ts=-1                // Valor que devuelve si no lo encuentra
   muestra=0;
   largo=length(vector_senial); // Largo del vector
   for i=1:largo
      if vector_senial(i)>(valor_final*(1+porcentaje)) | vector_senial(i)<(valor_final*(1-porcentaje)) then
      // Encontramos el valor o la transición
         muestra=i;
      end;
   end
   ts = vector_tiempo(muestra);
endfunction

//*****************************************************************************
function plotFondoBlanco()
/* Establece color de fondo blanco para plot()
*/
   hf=gcf()
   hf.background = -2;
endfunction

//*****************************************************************************
function plotLimites(x1,y1,x2,y2)
/* Establece los límites de plot() */
   ha=gca()
   ha.data_bounds = [x1,y1;x2,y2];
endfunction

//*****************************************************************************
function tsa = TiempoEstablecimientoAproximado(zeta,wn)
/*   */
   tsa = (4/zeta + 7*zeta - 5)/wn;
endfunction

//*****************************************************************************
function paleta = figurePaletaAzul(niveles)
    paleta = [linspace(0, 0, niveles)', linspace(1, 0, niveles)', ones(niveles, 1)]; 
    f = gcf();
    f.color_map = paleta;
endfunction

//*****************************************************************************
function paleta = figurePaletaArcoIris(niveles)
    paleta = zeros(niveles,3);
    paleta (1,:) = [0, 1, 0];
    suma = paleta (1,1) + paleta (1,2) + paleta (1,3) // color inicial
    if (paleta(1,1)>0) then
       indice_resta = 1;
       indice_suma = 2;
    else if (paleta(1,2)>0) then
       indice_resta = 2;
       indice_suma = 3;
    else
       indice_resta = 3;
       indice_suma = 1;      
    end
    end
    delta = 2 / (niveles);
    
    for i=2:niveles
        paleta (i, indice_resta) = paleta(i-1, indice_resta)-delta;
        paleta (i, indice_suma)  = paleta(i-1, indice_suma)+delta;
        if (paleta (i, indice_resta) < (delta/3) ) then
           paleta(i, indice_resta) = 0;
           paleta(i, indice_suma)  = suma - paleta(i, indice_resta)
           indice_resta = mod( indice_resta, 3 )+1;
           indice_suma  = mod( indice_suma,  3 )+1;
        end
    end
    f = gcf();
    f.color_map = paleta;
endfunction

//*****************************************************************************
function rgb = hsl2rgb(h, s, l)
/* Pasa de HSL a color RGB */
    c = (1 - abs(2*l - 1)) * s;
    x = c * (1 - abs (mod(h / 60, 2) - 1));
    m = l - c/2;
    if (h < 60) then
        r1 = c; g1 = x; b1 = 0;
    elseif (h < 120) then
        r1 = x; g1 = c; b1 = 0;
    elseif (h < 180) then
        r1 = 0; g1 = c; b1 = x;
    elseif (h < 240) then
        r1 = 0; g1 = x; b1 = c;
    elseif (h < 300) then
        r1 = x; g1 = 0; b1 = c;
    else
        r1 = c; g1 = 0; b1 = x;
    end
    rgb = [(r1 + m), (g1 + m), (b1 + m)];
endfunction

//*****************************************************************************
function resto = mod (dividendo, divisor)
    resto = dividendo - floor(dividendo / divisor) * divisor
endfunction
