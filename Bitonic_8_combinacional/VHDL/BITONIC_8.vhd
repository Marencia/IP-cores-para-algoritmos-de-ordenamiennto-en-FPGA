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

	--================================================================================
	-- Señales
   --================================================================================
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
	
	GEN_ETAPA_1: for i in 0 to 3 generate
    
        GEN_UP: if i = 0 or i = 2 generate
            CAS1_UP: entity work.CAS_UP
            port map(
                D1 => DATA_SIGNAL(2*i), D2 => DATA_SIGNAL(2*i+1),
                Y1 => ETAPA_1(2*i),     Y2 => ETAPA_1(2*i+1)
            );
        end generate;

        GEN_DOWN: if i = 1 or i = 3 generate
            CAS1_DOWN: entity work.CAS_DOWN
            port map(
                D1 => DATA_SIGNAL(2*i), D2 => DATA_SIGNAL(2*i+1),
                Y1 => ETAPA_1(2*i),     Y2 => ETAPA_1(2*i+1)
            );
        end generate;
    end generate;
	 
	 
	--Comienzo de ETAPA_2 
	
	GEN_ETAPA_: for i in 0 to 1 generate
    
            CAS1_UP: entity work.CAS_UP
            port map(
                D1 => DATA_SIGNAL(i+4), D2 => DATA_SIGNAL(i+6),
                Y1 => ETAPA_2(i+4),     Y2 => ETAPA_2(i+6)
            );
      

            CAS1_DOWN: entity work.CAS_DOWN
            port map(
                D1 => DATA_SIGNAL(i), D2 => DATA_SIGNAL(i+2),
                Y1 => ETAPA_2(i),     Y2 => ETAPA_2(i+2)
            );
        end generate;
    	
	
	--Comienzo de ETAPA_3 
	
		GEN_ETAPA_: for i in 0 to 1 generate
    
            CAS1_UP: entity work.CAS_UP 
            port map(
                D1 => DATA_SIGNAL(2*i+4), D2 => DATA_SIGNAL(2*i+5),
                Y1 => ETAPA_3(2*i+4),     Y2 => ETAPA_3(2*i+5)
            );
      

            CAS1_DOWN: entity work.CAS_DOWN
            port map(
                D1 => DATA_SIGNAL(2*i), D2 => DATA_SIGNAL(2*i+1),
                Y1 => ETAPA_3(2*i),     Y2 => ETAPA_3(2*i+1)
            );
        end generate;
	
	
	--Comienzo de ETAPA_4 
	
		GEN_ETAPA_: for i in 0 to 3 generate
    
            CAS1_UP: entity work.CAS_UP 
            port map(
                D1 => DATA_SIGNAL(i), D2 => DATA_SIGNAL(i+4),
                Y1 => ETAPA_4(i),     Y2 => ETAPA_4(i+4)
            );
      
        end generate;
	
	
	--Comienzo de ETAPA_5 
	
		GEN_ETAPA_: for i in 0 to 1 generate
    
            CAS1_UP_A: entity work.CAS_UP 
            port map(
                D1 => DATA_SIGNAL(i), D2 => DATA_SIGNAL(i+2),
                Y1 => ETAPA_5(i),     Y2 => ETAPA_5(i+2)
            );
  
				CAS1_UP_B: entity work.CAS_UP 
            port map(
                D1 => DATA_SIGNAL(i+4), D2 => DATA_SIGNAL(i+6),
                Y1 => ETAPA_1(i+4),     Y2 => ETAPA_1(i+6)
            );
				
        end generate;
	
	
	--Comienzo de ETAPA_6
	
		GEN_ETAPA_: for i in 0 to 3 generate
    
            CAS1_UP: entity work.CAS_UP 
            port map(
                D1 => DATA_SIGNAL(2*i), D2 => DATA_SIGNAL(2*i+1),
                Y1 => OUTPUT_SIGNAL(2*i),     Y2 => OUTPUT_SIGNAL(2*i+1)
            );
				
        end generate;
	
	
	SALIDA <= OUTPUT_SIGNAL;
	
end Behavior;
