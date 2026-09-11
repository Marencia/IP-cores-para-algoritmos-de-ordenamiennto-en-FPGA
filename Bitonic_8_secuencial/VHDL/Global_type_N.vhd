library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

package Global_types is

    constant N_DATOS : integer := 8;
    constant N_BITS  : integer := 8;
	 
	 function N_ETAPAS(N_DATOS : integer) return natural;
	 function N_FASES (N_DATOS : integer) return natural;	
	 function GET_FILA(fase_i  : integer; etapa_j : integer) return natural;
	
    type VEC_DATOS is array (0 to N_DATOS - 1) of std_logic_vector(N_BITS-1 downto 0);
    type VEC_ETAPAS is array (0 to N_ETAPAS(N_DATOS)-1) of VEC_DATOS; --problema!
	 type VEC_REGISTROS is array (0 to N_ETAPAS(N_DATOS)) of VEC_DATOS;
	 
end package Global_types;

package body Global_types is

	
	----------------- FUNCION PARA CALCULAR FASES ------------------
	
	function N_FASES (N_DATOS : integer) return natural is
		
		variable aux  : integer := N_DATOS;
		variable cont : natural := 0;
		
	begin
		L1: while aux > 1 loop
				aux  := aux / 2;
				cont := cont + 1;
			 end loop L1;
			 
		return cont;
			 
	end function N_FASES;
	
	----------------- FUNCION PARA CALCULAR ETAPAS -----------------
	
	function N_ETAPAS(N_DATOS : integer) return natural is
		
	begin
			  return (N_FASES(N_DATOS)*(N_FASES(N_DATOS)+1))/2;
			 
	end function N_ETAPAS;
	
	
	------------------- FUNCION PARA MAPEAR FILA -------------------
	
	function GET_FILA(fase_i: integer; etapa_j:integer) return natural is
	begin
			
			return((fase_i * (fase_i  + 1)) / 2) + etapa_j;
			
	end function GET_FILA;
	
	
end package body;
