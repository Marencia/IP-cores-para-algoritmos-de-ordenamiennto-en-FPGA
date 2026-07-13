library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Tb_CAS_UP is

	generic (
		N : integer :=8
	);
	
end Tb_CAS_UP;

architecture Behavioral of Tb_CAS_UP is

	signal A  : std_logic_vector(N-1 downto 0);
	signal B  : std_logic_vector(N-1 downto 0);
	signal Y1 : std_logic_vector(N-1 downto 0);
	signal Y2 : std_logic_vector(N-1 downto 0);

begin
	
		DUT: entity work.CAS_UP
			port map(
				D1  => A,
				D2  => B,
				Y1  => Y1,
				Y2  => Y2
			);
			
		process
		begin
		
			A <= std_logic_vector(to_unsigned(10,8));
			B <= std_logic_vector(to_unsigned(20,8));
			wait for 20 ns;
			
			A <= std_logic_vector(to_unsigned(30,8));
			B <= std_logic_vector(to_unsigned(5,8));
			wait for 20 ns;
			
			A <= std_logic_vector(to_unsigned(15,8));
			B <= std_logic_vector(to_unsigned(15,8));
			wait for 20 ns;
			
			A <= std_logic_vector(to_unsigned(255,8));
			B <= std_logic_vector(to_unsigned(0,8));
			wait for 20 ns;
			
			wait;
			
		end process;
		
	end Behavioral;