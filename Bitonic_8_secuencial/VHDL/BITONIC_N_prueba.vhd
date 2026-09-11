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
	signal ETAPAS_N     : VEC_ETAPAS;
	
 --================================================================================
	-- SEÑALES DE ENTRADA Y SALIDA PARA REGISTROS
   --================================================================================ 
	
	signal R_ETAPAS_N: VEC_REGISTROS;
   signal r_salida  : VEC_DATOS;
	
	constant FASE_N 	 : natural := N_FASES(N_DATOS); -- constante con cantidad de fases (par N=8 son 3)
	constant TOTAL_E	 : natural := N_FASES(N_DATOS); -- 
	
begin

	--=================PRUEBA NUEVA=====================--
	
	FOR_FASES: for i in 0 to FASE_N-1 generate
				  begin				  
				  FOR_ETAPAS: for j in 0 to i generate
										
									constant fila   : natural := GET_FILA(i,j);
									constant DIST_O : natural := 2 ** (i-j);
									
									begin
									FOR_XOR: for k in 0 to N_DATOS - 1 generate 
									constant DIST_ACT : natural := to_integer(to_unsigned(k, FASE_N + 1) xor to_unsigned(DIST_O, FASE_N + 1));	-- comparacion bit a bit para calcular distancia entre elementos
									
													begin
													GEN_PAR: if DIST_ACT > k generate 
																constant ES_UP : boolean := ((k / (2 ** (i + 1))) mod 2) = 0;
																
																begin
																GEN_UP : if ES_UP generate
																		CAS_UP: entity work.CAS_UP
																		port map(
																			D1 => R_ETAPAS_N(fila)(k), D2 => R_ETAPAS_N(fila)(DIST_ACT),
																			Y1 => ETAPAS_N(fila)(k),   Y2 => ETAPAS_N(fila)(DIST_ACT)
																		);
																			end generate GEN_UP;
																GEN_DOWN: if not ES_UP generate
																		CAS_DOWN: entity work.CAS_DOWN
																		port map(
																			D1 => R_ETAPAS_N(fila)(k), D2 => R_ETAPAS_N(fila)(DIST_ACT),
																			Y1 => ETAPAS_N(fila)(k),   Y2 => ETAPAS_N(fila)(DIST_ACT)
																		);
																		end generate GEN_DOWN;
													end generate GEN_PAR;								
											  end generate FOR_XOR;
								 end generate FOR_ETAPAS;
					end generate FOR_FASES;			


    --====================================================================
    -- PROCESO SÍNCRONO
    --====================================================================
    process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
					for s in 0 to TOTAL_E loop
						for elem in 0 to N_DATOS - 1 loop
						 -- Inicialización de todos los registros en cero
							R_ETAPAS_N(s)(elem) <= (others => '0');
						 end loop;
					end loop;
					r_salida  <= (others => (others => '0'));
		  else
				-- Captura de datos en cada flanco de reloj
					 R_ETAPAS_N(0) <= DATOS;
				-- R intermedios
                for s in 0 to TOTAL_E - 1 loop
						R_ETAPAS_N(s + 1) <= ETAPAS_N(s);
					 end loop; 
				-- Registro final de salida
					 r_salida  <= R_ETAPAS_N(TOTAL_E); 
            end if;
        end if;
    end process;

    --================================================================
    -- ASIGNACIÓN DE SALIDA FÍSICA
    --================================================================
    SALIDA <= r_salida;

end Behavior;
