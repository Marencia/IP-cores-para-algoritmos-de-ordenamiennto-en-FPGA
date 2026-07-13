## Notas sobre el código ##

Dentro de Gobal_types se encuenctran definidos los tipos de datos.

La variable parametrizable que se utiliza para modificar la cantidad de bits es:

     N_BITS  : integer := 8 -- Tipo entero

La vaariable queindica la cantidaad de elementos es:

      N_DATOS : integer := 8 -- Tipo entero

El dato que ingresa a los CAS son de tipo vector y se encuentran declarados de la siguiente forma:

      type VEC_DATOS is array (0 to N_DATOS - 1) of std_logic_vector(N_BITS-1 downto 0);

