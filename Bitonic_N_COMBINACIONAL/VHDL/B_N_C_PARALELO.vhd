library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.Global_types.ALL;

--Ingreso de datos en paralelo--

entity BITONIC_COMB_N is

	port(
		DATOS : in  VEC_DATOS;
		SALIDA: out VEC_DATOS
	);
	
end BITONIC_COMB_N;

architecture Behavior of BITONIC_COMB_N is

	--================================================================================
	-- Señales
   --================================================================================
	signal ETAPAS_N    : VEC_ETAPAS;
	----------------------------------------------------------------------------------

	constant FASE_N 	 : natural := N_FASES(N_DATOS); -- constante con cantidad de fases (par N=8 son 3)
	constant TOTAL_E	 : natural := N_ETAPAS(N_DATOS); -- 
	
begin

	ETAPAS_N(0) <= DATOS;

		FOR_FASES: for i in 0 to FASE_N-1 generate
				  begin				  
				  FOR_ETAPAS: for j in 0 to i generate
										
									constant fila   : natural := GET_FILA(i,j);
									constant DIST_O : natural :=    2 ** (i-j);
									
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
																			D1 => ETAPAS_N(fila)(k),  D2 => ETAPAS_N(fila)(DIST_ACT),
																			Y1 => ETAPAS_N(fila+1)(k), Y2 => ETAPAS_N(fila+1)(DIST_ACT)
																		);
																			end generate GEN_UP;
																GEN_DOWN: if not ES_UP generate
																		CAS_DOWN: entity work.CAS_DOWN
																		port map(
																			D1 => ETAPAS_N(fila)(k),  D2 => ETAPAS_N(fila)(DIST_ACT),
																			Y1 => ETAPAS_N(fila+1)(k), Y2 => ETAPAS_N(fila+1)(DIST_ACT)
																		);
																		end generate GEN_DOWN;
												end generate GEN_PAR;								
									end generate FOR_XOR;
					end generate FOR_ETAPAS;
		end generate FOR_FASES;			
	
	SALIDA <= ETAPAS_N(TOTAL_E);
	
end Behavior;
