# BITONIC 8 BITS Y 8 ELEMENTOS COMBINACIONAL #

## Bitonic merge sort ##

El algoritmo de ordenamiento Bitonic merge sort se basa en etapas de comparaciones e intercambios entre dos elementos.
Las etapas se denominan BM-xs, siendo 'x' el número de elementos o canales que se están fusionando en esa etapa. 

![Imagen](https://github.com/Marencia/IP-cores-para-algoritmos-de-ordenamiennto-en-FPGA/blob/main/Bitonic_8_combinacional/img/Bitonic_8.png)  
*Internals of Bitonic Sort by Xilinx.*

Cada columna contiene comparaciones que se realizan en paralelo y el resultado de las mismas hacen de entradas para las 
siguientes comparaciones. Las flechas marcan si el elemento de mayor valor queda en la posición superior o en la inferior.

## Bitonic secuencial ##

El código presentado se realiza con lógica secuencial. Los PRO y CONTRA de este tipo de VHD son:

PROS:

- Frecuencia de reloj alta: El camino crític es la etapa coombinacional más lenta entre dos registros.  
- Throughput: Por cada ciclo de reloj se ingresa una nueva serie de datos.  
- Sin glitches: Los registros funcionan como filtros que no dejan pasar los glitches.  
- Escalabilidad: Su estructura permite diseñar modelos de mayor dimensión.  

CONTRAS:

- Mayor latencia inicial: Un dato individual tarda más tiempo en salir, ya que pasa por cada registro y espera al pulso de clk.  
- Mayor uso de recursos: No solo se utiliza la estructura combinnacional, sino que se le agregan los registros.  

  
![RTL_viewer](https://github.com/Marencia/IP-cores-para-algoritmos-de-ordenamiennto-en-FPGA/blob/main/Bitonic_8_secuencial/img/RTL_bitonic_secuencial.png)  
*RTL viewer*

![Recursos](https://github.com/Marencia/IP-cores-para-algoritmos-de-ordenamiennto-en-FPGA/blob/main/Bitonic_8_secuencial/img/compilaci%C3%B3n_secuenciaaal.png)  
*Recursos de compilación*

## Testbench ##

![TB](https://github.com/Marencia/IP-cores-para-algoritmos-de-ordenamiennto-en-FPGA/blob/main/Bitonic_8_secuencial/img/TB_secuencial.png)  
*Simulación*  

Se  puede observar en la simulación cómo la salida mestra los valores ordenados una  vez que pasaron los 6 ciclos de reloj tras recorrer las 6 etapas de CAS con registros intermedios.
