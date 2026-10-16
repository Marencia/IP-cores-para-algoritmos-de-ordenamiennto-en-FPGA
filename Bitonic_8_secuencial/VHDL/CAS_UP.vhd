library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.Global_types.ALL;

entity CAS_UP is
		
	port(
		D1,D2 : in  std_logic_vector(N_BITS-1 downto 0);
		Y1,Y2 : out std_logic_vector(N_BITS-1 downto 0)
	);
	
end CAS_UP;

architecture Behavior of CAS_UP is

begin
	process(D1,D2)
	begin
		
		if unsigned(D1)<unsigned(D2) then
			Y1 <= D1;
			Y2 <= D2;
		else
			Y1 <= D2;
			Y2 <= D1;
		end if;	
	end process;
		
end Behavior;
