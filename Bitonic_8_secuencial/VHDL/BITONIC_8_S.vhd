library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.Global_types.ALL;

entity BITONIC_8_S is
    port(
        clk    : in  std_logic;
        reset  : in  std_logic;
        DATOS  : in  VEC_DATOS;
        SALIDA : out VEC_DATOS
    );
end BITONIC_8_S;

architecture Behavior of BITONIC_8_S is

   --================================================================================
	-- SEÑALES DE SALIDA DE COMBINACIONAL DE BM-Xs
   --================================================================================
	signal DATA_SIGNAL  : VEC_DATOS;
	signal ETAPA_1		  : VEC_DATOS;
	signal ETAPA_2		  : VEC_DATOS;
	signal ETAPA_3		  : VEC_DATOS;
	signal ETAPA_4		  : VEC_DATOS;
	signal ETAPA_5		  : VEC_DATOS;
	signal OUTPUT_SIGNAL: VEC_DATOS;

   --================================================================================
   -- SEÑALES DE REGISTROS INTERMEDIOS
   --================================================================================
   signal r_etapa_1 : VEC_DATOS;
   signal r_etapa_2 : VEC_DATOS;
   signal r_etapa_3 : VEC_DATOS;
   signal r_etapa_4 : VEC_DATOS;
   signal r_etapa_5 : VEC_DATOS;
   signal r_salida  : VEC_DATOS;


begin
    --================================================================
    -- ETAPA 1: Combinacional
    --================================================================
    GEN_ETAPA_1: for i in 0 to 3 generate
        GEN_UP: if i = 0 or i = 2 generate
            CAS1_UP: entity work.CAS_UP
            port map(
                D1 => DATOS(2*i), 
				D2 => DATOS(2*i+1),
                Y1 => ETAPA_1(2*i), 
				Y2 => ETAPA_1(2*i+1)
            );
        end generate;

        GEN_DOWN: if i = 1 or i = 3 generate
            CAS1_DOWN: entity work.CAS_DOWN
            port map(
                D1 => DATOS(2*i), 
				D2 => DATOS(2*i+1),
                Y1 => ETAPA_1(2*i), 
				Y2 => ETAPA_1(2*i+1)
            );
        end generate;
    end generate;

    --=====================================================================
    -- ETAPA 2: Combinacional (Toma como entrada la salida del registro 1)
    --=====================================================================
    GEN_ETAPA_2: for i in 0 to 1 generate
        CAS2_DOWN: entity work.CAS_DOWN
        port map (
            D1 => r_etapa_1(i), 
			D2 => r_etapa_1(i+2),
            Y1 => ETAPA_2(i), 
			Y2 => ETAPA_2(i+2)
        );
        CAS2_UP: entity work.CAS_UP
        port map (
            D1 => r_etapa_1(i+4), 
			D2 => r_etapa_1(i+6),
            Y1 => ETAPA_2(i+4), 
			Y2 => ETAPA_2(i+6)
        );
    end generate;

    --====================================================================
    -- ETAPA 3: Combinacional (Toma como entrada la salida del egistro 2)
    --====================================================================
    GEN_ETAPA_3: for i in 0 to 1 generate
        CAS3_DOWN: entity work.CAS_DOWN
        port map (
            D1 => r_etapa_2(2*i), 
			D2 => r_etapa_2(2*i+1),
            Y1 => ETAPA_3(2*i), 
			Y2 => ETAPA_3(2*i+1)
        );
        CAS3_UP: entity work.CAS_UP
        port map (
            D1 => r_etapa_2(2*i+4), 
			D2 => r_etapa_2(2*i+5),
            Y1 => ETAPA_3(2*i+4), 
			Y2 => ETAPA_3(2*i+5)
        );
    end generate;

    --====================================================================
    -- ETAPA 4: Combinacional (Toma como entrada la salida del Registro 3)
    --====================================================================
    GEN_ETAPA_4: for i in 0 to 3 generate
        CAS4_UP: entity work.CAS_UP
        port map (
            D1 => r_etapa_3(i), 
			D2 => r_etapa_3(i+4),
            Y1 => ETAPA_4(i), 
			Y2 => ETAPA_4(i+4)
        );
    end generate;

    --====================================================================
    -- ETAPA 5: Combinacional (Toma como entrada la salida del Registro 4)
    --====================================================================
    GEN_ETAPA_5: for i in 0 to 1 generate
        CAS5_UP_B1: entity work.CAS_UP
        port map (
            D1 => r_etapa_4(i), 
			D2 => r_etapa_4(i+2),
            Y1 => ETAPA_5(i), 
			Y2 => ETAPA_5(i+2)
        );
        CAS5_UP_B2: entity work.CAS_UP
        port map (
            D1 => r_etapa_4(i+4), 
			D2 => r_etapa_4(i+6),
            Y1 => ETAPA_5(i+4), 
			Y2 => ETAPA_5(i+6)
        );
    end generate;

    --====================================================================
    -- ETAPA 6: Combinacional (Toma como entrada la salida del Registro 5)
    --====================================================================
    GEN_ETAPA_6: for i in 0 to 3 generate
        CAS6_UP: entity work.CAS_UP
        port map (
            D1 => r_etapa_5(2*i), 
			D2 => r_etapa_5(2*i+1),
            Y1 => OUTPUT_SIGNAL(2*i), 
			Y2 => OUTPUT_SIGNAL(2*i+1)
        );
    end generate;


    --====================================================================
    -- PROCESO SÍNCRONO
    --====================================================================
    process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                -- Inicialización de todos los registros y bits en cero. 'Others' permite haceer todo cero sin depender de la dimensión.
                r_etapa_1 <= (others => (others => '0'));
                r_etapa_2 <= (others => (others => '0'));
                r_etapa_3 <= (others => (others => '0'));
                r_etapa_4 <= (others => (others => '0'));
                r_etapa_5 <= (others => (others => '0'));
                r_salida  <= (others => (others => '0'));
            else
                -- Captura de datos en cada flanco de reloj
                r_etapa_1 <= ETAPA_1;
                r_etapa_2 <= ETAPA_2;
                r_etapa_3 <= ETAPA_3;
                r_etapa_4 <= ETAPA_4;
                r_etapa_5 <= ETAPA_5;
                r_salida  <= OUTPUT_SIGNAL; 
            end if;
        end if;
    end process;

    --================================================================
    -- ASIGNACIÓN DE SALIDA FÍSICA
    --================================================================
    SALIDA <= r_salida;

end Behavior;
