library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.Global_types.ALL;

entity BITONIC_8_tb is
end BITONIC_8_tb;

architecture behavior of BITONIC_8_tb is

    signal tb_DATOS  : VEC_DATOS := (others => (others => '0'));
    signal tb_SALIDA : VEC_DATOS;

begin

    DUT: entity work.BITONIC_8
    port map (
        DATOS  => tb_DATOS,
        SALIDA => tb_SALIDA
    );

    stim_proc: process
    begin		
        -- Tiempo de espera inicial
        wait for 20 ns;

        ----------------------------------------------------------------
        -- CASO DE PRUEBA 1: Cargamos 8 números desordenados
        ----------------------------------------------------------------
        -- Recordá que cada posición es un std_logic_vector (por ejemplo, de 8 bits)
        -- Podés asignarlos usando números con to_unsigned o directamente en binario/hexadecimal
        
        tb_DATOS(0) <= std_logic_vector(to_unsigned(15, N_BITS));
        tb_DATOS(1) <= std_logic_vector(to_unsigned(2,  N_BITS));
        tb_DATOS(2) <= std_logic_vector(to_unsigned(8,  N_BITS));
        tb_DATOS(3) <= std_logic_vector(to_unsigned(20, N_BITS));
        tb_DATOS(4) <= std_logic_vector(to_unsigned(1,  N_BITS));
        tb_DATOS(5) <= std_logic_vector(to_unsigned(35, N_BITS));
        tb_DATOS(6) <= std_logic_vector(to_unsigned(12, N_BITS));
        tb_DATOS(7) <= std_logic_vector(to_unsigned(5,  N_BITS));

        -- Esperamos a que la lógica combinacional procese los datos y los ordene
        wait for 50 ns;

        ----------------------------------------------------------------
        -- CASO DE PRUEBA 2: Otro set de números para verificar
        ----------------------------------------------------------------
        tb_DATOS(0) <= std_logic_vector(to_unsigned(100, N_BITS));
        tb_DATOS(1) <= std_logic_vector(to_unsigned(90,  N_BITS));
        tb_DATOS(2) <= std_logic_vector(to_unsigned(80,  N_BITS));
        tb_DATOS(3) <= std_logic_vector(to_unsigned(70,  N_BITS));
        tb_DATOS(4) <= std_logic_vector(to_unsigned(60,  N_BITS));
        tb_DATOS(5) <= std_logic_vector(to_unsigned(50,  N_BITS));
        tb_DATOS(6) <= std_logic_vector(to_unsigned(40,  N_BITS));
        tb_DATOS(7) <= std_logic_vector(to_unsigned(30,  N_BITS));

        wait for 50 ns;

        -- Detener la simulación
        wait;
    end process;

end behavior;