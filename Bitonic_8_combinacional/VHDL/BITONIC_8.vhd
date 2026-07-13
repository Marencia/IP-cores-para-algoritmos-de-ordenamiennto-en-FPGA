library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.Global_types.ALL;

--Ingreso de datos en paralelo--

entity BITONIC_8 is

	port(
		DATOS : in  VEC_DATOS;
		SALIDA: out VEC_DATOS
	);
	
end BITONIC_8;

architecture Behavior of BITONIC_8 is

	--------Declaración de tipo de datos vector con elementos std_logic_vector--------

	signal DATA_SIGNAL  : VEC_DATOS;
	signal ETAPA_1		  : VEC_DATOS;
	signal ETAPA_2		  : VEC_DATOS;
	signal ETAPA_3		  : VEC_DATOS;
	signal ETAPA_4		  : VEC_DATOS;
	signal ETAPA_5		  : VEC_DATOS;
	signal OUTPUT_SIGNAL: VEC_DATOS;
	----------------------------------------------------------------------------------

	
begin

	DATA_SIGNAL   <= DATOS; --carga todos los datos de una en forma paralela

	--Comienzo de ETAPA_1 
	
	CAS1_1: entity work.CAS_UP
	port map(
		D1 => DATA_SIGNAL(0),
		D2 => DATA_SIGNAL(1),
		Y1 => ETAPA_1(0), 
      Y2 => ETAPA_1(1)
	);
	
	CAS1_2: entity work.CAS_DOWN
	port map(
		D1 => DATA_SIGNAL(2),
		D2 => DATA_SIGNAL(3),
		Y1 => ETAPA_1(2), 
      Y2 => ETAPA_1(3)
	);
	
	CAS1_3: entity work.CAS_UP
	port map(
		D1 => DATA_SIGNAL(4),
		D2 => DATA_SIGNAL(5),
		Y1 => ETAPA_1(4), 
      Y2 => ETAPA_1(5)
	);
	
	CAS1_4: entity work.CAS_DOWN
	port map(
		D1 => DATA_SIGNAL(6),
		D2 => DATA_SIGNAL(7),
		Y1 => ETAPA_1(6), 
      Y2 => ETAPA_1(7)
	);
	 
	--Comienzo de ETAPA_2 
	
	CAS2_1: entity work.CAS_DOWN
	port map (
		D1 => ETAPA_1(0),
		D2 => ETAPA_1(2),
		Y1 => ETAPA_2(0),
		Y2 => ETAPA_2(2)
	);
	
	CAS2_2: entity work.CAS_DOWN
	port map (
		D1 => ETAPA_1(1),
		D2 => ETAPA_1(3),
		Y1 => ETAPA_2(1),
		Y2 => ETAPA_2(3)
	);
	
	CAS2_3: entity work.CAS_UP
	port map (
		D1 => ETAPA_1(5),
		D2 => ETAPA_1(7),
		Y1 => ETAPA_2(5),
		Y2 => ETAPA_2(7)
	);
	
	CAS2_4: entity work.CAS_UP
	port map (
		D1 => ETAPA_1(4),
		D2 => ETAPA_1(6),
		Y1 => ETAPA_2(4),
		Y2 => ETAPA_2(6)
	);
	
	--Comienzo de ETAPA_3 
	
	CAS3_1: entity work.CAS_DOWN
	port map (
		D1 => ETAPA_2(0),
		D2 => ETAPA_2(1),
		Y1 => ETAPA_3(0),
		Y2 => ETAPA_3(1)
	);
	
	CAS3_2: entity work.CAS_DOWN
	port map (
		D1 => ETAPA_2(2),
		D2 => ETAPA_2(3),
		Y1 => ETAPA_3(2),
		Y2 => ETAPA_3(3)
	);
	
	CAS3_3: entity work.CAS_UP
	port map (
		D1 => ETAPA_2(4),
		D2 => ETAPA_2(5),
		Y1 => ETAPA_3(4),
		Y2 => ETAPA_3(5)
	);
	
	CAS3_4: entity work.CAS_UP
	port map (
		D1 => ETAPA_2(6),
		D2 => ETAPA_2(7),
		Y1 => ETAPA_3(6),
		Y2 => ETAPA_3(7) 
	);
	
	--Comienzo de ETAPA_4 
	
	CAS4_1: entity work.CAS_UP
	port map (
		D1 => ETAPA_3(0),
		D2 => ETAPA_3(4),
		Y1 => ETAPA_4(0),
		Y2 => ETAPA_4(4)
	);
	
	CAS4_2: entity work.CAS_UP
	port map (
		D1 => ETAPA_3(1),
		D2 => ETAPA_3(5),
		Y1 => ETAPA_4(1),
		Y2 => ETAPA_4(5)
	);
	
	CAS4_3: entity work.CAS_UP
	port map (
		D1 => ETAPA_3(2),
		D2 => ETAPA_3(6),
		Y1 => ETAPA_4(2),
		Y2 => ETAPA_4(6)
	);
	
	CAS4_4: entity work.CAS_UP
	port map (
		D1 => ETAPA_3(3),
		D2 => ETAPA_3(7),
		Y1 => ETAPA_4(3),
		Y2 => ETAPA_4(7) 
	);
	
	
	--Comienzo de ETAPA_5 
	
	CAS5_1: entity work.CAS_UP
	port map (
		D1 => ETAPA_4(0),
		D2 => ETAPA_4(2),
		Y1 => ETAPA_5(0),
		Y2 => ETAPA_5(2)
	);
	
	CAS5_2: entity work.CAS_UP
	port map (
		D1 => ETAPA_4(1),
		D2 => ETAPA_4(3),
		Y1 => ETAPA_5(1),
		Y2 => ETAPA_5(3)
	);
	
	CAS5_3: entity work.CAS_UP
	port map (
		D1 => ETAPA_4(4),
		D2 => ETAPA_4(6),
		Y1 => ETAPA_5(4),
		Y2 => ETAPA_5(6)
	);
	
	CAS5_4: entity work.CAS_UP
	port map (
		D1 => ETAPA_4(5),
		D2 => ETAPA_4(7),
		Y1 => ETAPA_5(5),
		Y2 => ETAPA_5(7)
	);
	
	--Comienzo de ETAPA_6
	
	CAS6_1: entity work.CAS_UP
	port map (
		D1 => ETAPA_5(0),
		D2 => ETAPA_5(1),
		Y1 => OUTPUT_SIGNAL(0),
		Y2 => OUTPUT_SIGNAL(1)
	);
	
	CAS6_2: entity work.CAS_UP
	port map (
		D1 => ETAPA_5(2),
		D2 => ETAPA_5(3),
		Y1 => OUTPUT_SIGNAL(2),
		Y2 => OUTPUT_SIGNAL(3)
	);
	
	CAS6_3: entity work.CAS_UP
	port map (
		D1 => ETAPA_5(4),
		D2 => ETAPA_5(5),
		Y1 => OUTPUT_SIGNAL(4),
		Y2 => OUTPUT_SIGNAL(5)
	);
	
	CAS6_4: entity work.CAS_UP
	port map (
		D1 => ETAPA_5(6),
		D2 => ETAPA_5(7),
		Y1 => OUTPUT_SIGNAL(6),
		Y2 => OUTPUT_SIGNAL(7)
	);
	
	SALIDA <= OUTPUT_SIGNAL;
	
end Behavior;