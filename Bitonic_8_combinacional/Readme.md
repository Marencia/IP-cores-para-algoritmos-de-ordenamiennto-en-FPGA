# BITONIC 8 BITS Y 8 ELEMENTOS COMBINACIONAL #

## Bitonic merge sort ##

El algoritmo de ordenamiento Bitonic merge sort se basa en etapas de comparaciones e intercambios entre dos elementos.
Las etapas se denominan BM-xs, siendo 'x' el número de elementos o canales que se están fusionando en esa etapa. 

![Imagen](https://github.com/Marencia/IP-cores-para-algoritmos-de-ordenamiennto-en-FPGA/blob/main/Bitonic_8_combinacional/img/Bitonic_8.png)  
*Internals of Bitonic Sort by Xilinx.*

Cada columna contiene comparaciones que se realizan en paralelo y el resultado de las mismas hacen de entradas para las 
siguientes comparaciones. Las flechas marcan si el elemento de mayor valor queda en la posición superior o en la inferior.
