library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.Global_types.ALL;

entity TB_BITONIC_N is
end TB_BITONIC_N;

architecture sim of TB_BITONIC_N is

    -- Período de reloj: 10 ns (100 MHz)
    constant CLK_PERIOD : time := 10 ns;
    
    -- Latencia total del pipeline: etapas intermedias + registro de salida
    constant PIPELINE_LATENCY : natural := N_ETAPAS(N_DATOS) + 1;

    -- Señales de estímulo y monitoreo
    signal clk    : std_logic := '0';
    signal reset  : std_logic := '0';
    signal DATOS  : VEC_DATOS := (others => (others => '0'));
    signal SALIDA : VEC_DATOS;

    -- Bandera para detener el generador de reloj
    signal sim_finished : boolean := false;

begin

    --================================================================
    -- 1. INSTANCIACIÓN DEL DUT (Device Under Test)
    --================================================================
    DUT: entity work.BITONIC_8_S
        port map(
            clk    => clk,
            reset  => reset,
            DATOS  => DATOS,
            SALIDA => SALIDA
        );

    --================================================================
    -- 2. GENERADOR DE RELOJ
    --================================================================
    process
    begin
        while not sim_finished loop
            clk <= '0';
            wait for CLK_PERIOD / 2;
            clk <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
        wait;
    end process;

    --================================================================
    -- 3. PROCESO DE ESTÍMULOS Y VERIFICACIÓN
    --================================================================
    process
    begin
      -- Reset
		reset <= '1';
		wait for CLK_PERIOD * 2;
		wait until rising_edge(clk);
		reset <= '0';

		-- Esperamos 1 ciclo con entradas en 0 para que el reset limpie limpiamente
		wait until rising_edge(clk);
		
        --------------------------------------------------------------------
        -- TEST 1: Vector en orden estrictamente descendente
        --------------------------------------------------------------------
        report "--- Inyectando Test 1: Orden inverso ---";
		  DATOS(0)  <= std_logic_vector(to_unsigned(15, N_BITS));
        DATOS(1)  <= std_logic_vector(to_unsigned(14, N_BITS));
        DATOS(2)  <= std_logic_vector(to_unsigned(13, N_BITS));
        DATOS(3)  <= std_logic_vector(to_unsigned(12, N_BITS));
        DATOS(4)  <= std_logic_vector(to_unsigned(120, N_BITS));
        DATOS(5)  <= std_logic_vector(to_unsigned(110, N_BITS));
        DATOS(6)  <= std_logic_vector(to_unsigned(100, N_BITS));
        DATOS(7)  <= std_logic_vector(to_unsigned(90,  N_BITS));
--        DATOS(8)  <= std_logic_vector(to_unsigned(80,  N_BITS));
--        DATOS(9)  <= std_logic_vector(to_unsigned(70,  N_BITS));
--        DATOS(10) <= std_logic_vector(to_unsigned(60,  N_BITS));
--        DATOS(11) <= std_logic_vector(to_unsigned(50,  N_BITS));
--        DATOS(12) <= std_logic_vector(to_unsigned(40,  N_BITS));
--        DATOS(13) <= std_logic_vector(to_unsigned(30,  N_BITS));
--        DATOS(14) <= std_logic_vector(to_unsigned(20,  N_BITS));
--        DATOS(15) <= std_logic_vector(to_unsigned(10,  N_BITS));
        
		  
		  wait until rising_edge(clk);
		  
        --------------------------------------------------------------------
        -- TEST 2: Vector desordenado (se inyecta en el ciclo inmediato)
        --------------------------------------------------------------------
        report "--- Inyectando Test 2: Desordenado ---";
        DATOS(0)  <= std_logic_vector(to_unsigned(6, N_BITS));
        DATOS(1)  <= std_logic_vector(to_unsigned(5, N_BITS));
        DATOS(2)  <= std_logic_vector(to_unsigned(10, N_BITS));
        DATOS(3)  <= std_logic_vector(to_unsigned(12, N_BITS));
        DATOS(4)  <= std_logic_vector(to_unsigned(99, N_BITS));
        DATOS(5)  <= std_logic_vector(to_unsigned(35, N_BITS));
        DATOS(6)  <= std_logic_vector(to_unsigned(9,  N_BITS));
        DATOS(7)  <= std_logic_vector(to_unsigned(66, N_BITS));
--        DATOS(8)  <= std_logic_vector(to_unsigned(77, N_BITS));
--        DATOS(9)  <= std_logic_vector(to_unsigned(88, N_BITS));
--        DATOS(10) <= std_logic_vector(to_unsigned(11, N_BITS));
--        DATOS(11) <= std_logic_vector(to_unsigned(12, N_BITS));
--        DATOS(12) <= std_logic_vector(to_unsigned(7,  N_BITS));
--        DATOS(13) <= std_logic_vector(to_unsigned(21, N_BITS));
--        DATOS(14) <= std_logic_vector(to_unsigned(20, N_BITS));
--        DATOS(15) <= std_logic_vector(to_unsigned(81, N_BITS));
        
        
		  wait until rising_edge(clk);
		  
        --------------------------------------------------------------------
        -- TEST 3: Vector ya ordenado
        --------------------------------------------------------------------
        report "--- Inyectando Test 3: Ya ordenado ---";
        DATOS(0)  <= std_logic_vector(to_unsigned(1, N_BITS));
        DATOS(1)  <= std_logic_vector(to_unsigned(2, N_BITS));
        DATOS(2)  <= std_logic_vector(to_unsigned(3, N_BITS));
        DATOS(3)  <= std_logic_vector(to_unsigned(4, N_BITS));
        DATOS(4)  <= std_logic_vector(to_unsigned(5, N_BITS));
        DATOS(5)  <= std_logic_vector(to_unsigned(6, N_BITS));
        DATOS(6)  <= std_logic_vector(to_unsigned(7, N_BITS));
        DATOS(7)  <= std_logic_vector(to_unsigned(8,  N_BITS));
--        DATOS(8)  <= std_logic_vector(to_unsigned(9,  N_BITS));
--        DATOS(9)  <= std_logic_vector(to_unsigned(10,  N_BITS));
--        DATOS(10) <= std_logic_vector(to_unsigned(11,  N_BITS));
--        DATOS(11) <= std_logic_vector(to_unsigned(12,  N_BITS));
--        DATOS(12) <= std_logic_vector(to_unsigned(13,  N_BITS));
--        DATOS(13) <= std_logic_vector(to_unsigned(14,  N_BITS));
--        DATOS(14) <= std_logic_vector(to_unsigned(15,  N_BITS));
--        DATOS(15) <= std_logic_vector(to_unsigned(16,  N_BITS));
        
        
		  wait until rising_edge(clk);
		  
		  --------------------------------------------------------------------
        -- TEST 4: Vector nuevo
        --------------------------------------------------------------------
		  
		  report "--- Inyectando Test 4: Nuevo ---";
		  DATOS(0)  <= std_logic_vector(to_unsigned(7, N_BITS));
        DATOS(1)  <= std_logic_vector(to_unsigned(5, N_BITS));
        DATOS(2)  <= std_logic_vector(to_unsigned(6, N_BITS));
        DATOS(3)  <= std_logic_vector(to_unsigned(4, N_BITS));
        DATOS(4)  <= std_logic_vector(to_unsigned(22, N_BITS));
        DATOS(5)  <= std_logic_vector(to_unsigned(33, N_BITS));
        DATOS(6)  <= std_logic_vector(to_unsigned(11, N_BITS));
        DATOS(7)  <= std_logic_vector(to_unsigned(111,  N_BITS));
--        DATOS(8)  <= std_logic_vector(to_unsigned(99,  N_BITS));
--        DATOS(9)  <= std_logic_vector(to_unsigned(88,  N_BITS));
--        DATOS(10) <= std_logic_vector(to_unsigned(12,  N_BITS));
--        DATOS(11) <= std_logic_vector(to_unsigned(121,  N_BITS));
--        DATOS(12) <= std_logic_vector(to_unsigned(300,  N_BITS));
--        DATOS(13) <= std_logic_vector(to_unsigned(17,  N_BITS));
--        DATOS(14) <= std_logic_vector(to_unsigned(24,  N_BITS));
--        DATOS(15) <= std_logic_vector(to_unsigned(36,  N_BITS));
        
        
		  
		  wait until rising_edge(clk);
		  
		  --------------------------------------------------------------------
        -- TEST 5: Vector nuevo idem
        --------------------------------------------------------------------
		  
		  report "--- Inyectando Test 5: Nuevo igual---";
		  DATOS(0)  <= std_logic_vector(to_unsigned(11, N_BITS));
        DATOS(1)  <= std_logic_vector(to_unsigned(11, N_BITS));
        DATOS(2)  <= std_logic_vector(to_unsigned(11, N_BITS));
        DATOS(3)  <= std_logic_vector(to_unsigned(11, N_BITS));
        DATOS(4)  <= std_logic_vector(to_unsigned(111, N_BITS));
        DATOS(5)  <= std_logic_vector(to_unsigned(111, N_BITS));
        DATOS(6)  <= std_logic_vector(to_unsigned(111, N_BITS));
        DATOS(7)  <= std_logic_vector(to_unsigned(111,  N_BITS));
--        DATOS(8)  <= std_logic_vector(to_unsigned(111,  N_BITS));
--        DATOS(9)  <= std_logic_vector(to_unsigned(111,  N_BITS));
--        DATOS(10) <= std_logic_vector(to_unsigned(111,  N_BITS));
--        DATOS(11) <= std_logic_vector(to_unsigned(111,  N_BITS));
--        DATOS(12) <= std_logic_vector(to_unsigned(111,  N_BITS));
--        DATOS(13) <= std_logic_vector(to_unsigned(111,  N_BITS));
--        DATOS(14) <= std_logic_vector(to_unsigned(111,  N_BITS));
--        DATOS(15) <= std_logic_vector(to_unsigned(111,  N_BITS));
        
		  
		  wait until rising_edge(clk);
		  
        -- Limpieza de la entrada
        DATOS <= (others => (others => '0'));

        -- Espera hasta que el Test 1 emerja del pipeline
        wait for CLK_PERIOD * (PIPELINE_LATENCY - 2);

        --------------------------------------------------------------------
        -- COMPROBACIÓN DE SALIDAS
        --------------------------------------------------------------------
        report "Verificando salida Test 1...";
        assert (SALIDA(0) = std_logic_vector(to_unsigned(10, N_BITS)) and 
                SALIDA(1) = std_logic_vector(to_unsigned(20, N_BITS)) and
                SALIDA(2) = std_logic_vector(to_unsigned(30, N_BITS)) and
                SALIDA(3) = std_logic_vector(to_unsigned(40, N_BITS)) and
                SALIDA(4) = std_logic_vector(to_unsigned(50, N_BITS)) and
                SALIDA(5) = std_logic_vector(to_unsigned(60, N_BITS)) and
                SALIDA(6) = std_logic_vector(to_unsigned(70, N_BITS)) and
                SALIDA(7) = std_logic_vector(to_unsigned(80, N_BITS)))
            report "Error en Test 1: Ordenamiento incorrecto" severity error;
        wait for CLK_PERIOD;

        report "Verificando salida Test 2...";
        assert (SALIDA(0) = std_logic_vector(to_unsigned(0,  N_BITS)) and 
                SALIDA(1) = std_logic_vector(to_unsigned(3,  N_BITS)) and
                SALIDA(2) = std_logic_vector(to_unsigned(5,  N_BITS)) and
                SALIDA(3) = std_logic_vector(to_unsigned(12, N_BITS)) and
                SALIDA(4) = std_logic_vector(to_unsigned(15, N_BITS)) and
                SALIDA(5) = std_logic_vector(to_unsigned(42, N_BITS)) and
                SALIDA(6) = std_logic_vector(to_unsigned(77, N_BITS)) and
                SALIDA(7) = std_logic_vector(to_unsigned(99, N_BITS)))
            report "Error en Test 2: Ordenamiento incorrecto" severity error;
        wait for CLK_PERIOD;

        report "Verificando salida Test 3...";
        assert (SALIDA(0) = std_logic_vector(to_unsigned(1, N_BITS)) and 
                SALIDA(7) = std_logic_vector(to_unsigned(8, N_BITS)))
            report "Error en Test 3: Ordenamiento incorrecto" severity error;
        wait for CLK_PERIOD * 2;

        report "Simulacion completada exitosamente." severity note;
        sim_finished <= true;
        wait;
    end process;

end sim;