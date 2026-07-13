# BITONIC 8 BITS Y 8 ELEMENTOS COMBINACIONAL #

## Bitonic merge sort ##

El algoritmo de ordenamiento Bitonic merge sort se basa en etapas de comparaciones e intercambios entre dos elementos.
Las etapas se denominan BM-xs, siendo 'x' el número de elementos o canales que se están fusionando en esa etapa. 

![Imagen](https://github.com/Marencia/IP-cores-para-algoritmos-de-ordenamiennto-en-FPGA/blob/main/Bitonic_8_combinacional/img/Bitonic_8.png)  
*Internals of Bitonic Sort by Xilinx.*

Cada columna contiene comparaciones que se realizan en paralelo y el resultado de las mismas hacen de entradas para las 
siguientes comparaciones. Las flechas marcan si el elemento de mayor valor queda en la posición superior o en la inferior.

## Bitonic combinacional ##

El código presentado se realiza con lógica combinacional. Los PRO y CONTRA de este tipo de VHD son:

PROS:
  - Latencia mínima absoluta: Los datos no tienen que esperar a ningún reloj.
  - Diseño más simple: No requiere lidiar con varios relojes (clk), problemas de sincronización, ni análisis de tiempos complejos.
  - Menor consumo estático de registros: Al no usar Flip-Flops intermedias, se ahorran recursos internos de la FPGA si el vector no es gigantesco.
  - Ideal para bloques pequeños: Para operaciones lógicas directas, decodificadores o redes de pocos elementos.

CONTRAS:
  - Camino crítico largo: Si el circuito es grande, el retraso total de propagación se acumula. Es decir, menor velocidad.
  - Throughput: Hasta que el circuito no termine de calcular por completo el dato actual y este se estabilice en la salida, no se puede ingresar un nuevo dato en la entrada.
  - Glitches: Como los caminos eléctricos internos tienen longitudes ligeramente distintas, las compuertas conmutan a destiempo. Esto genera transiciones falsas y consumo de energía.
