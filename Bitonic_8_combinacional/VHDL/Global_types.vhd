library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package Global_types is

    constant N_DATOS : integer := 8;
    constant N_BITS  : integer := 8;
	 
    type VEC_DATOS is array (0 to N_DATOS - 1) of std_logic_vector(N_BITS-1 downto 0);
	 
end package;

--package body Global_types is
--end package body;