-- This test_bech file simulates the divider source file

-- number of bit definition per numerator and denominator
Package Types is 
	constant bits_num  : integer := 31;
	constant bits_den  : integer := 10; 
end Types;

-- usage of the defined package
library work;
use work.Types.all;

-- library inclusion
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY divider_test_bench is
	--port (); is empty in this section because it is already defined in the source 
end divider_test_bench;

ARCHITECTURE BEHAVIORAL of divider_test_bench is
	
	component divider
		port ( 
		num : in unsigned; --numerator of the division
		den : in unsigned; --denominator of the division
		clk : in std_logic;  --electronic clock
		go_div: in std_logic;
		zeta_out : out unsigned --output result
		);
	end component;
	
	signal num : unsigned (bits_num-1 downto 0);
	signal den : unsigned (bits_den-1 downto 0);
	signal clk : std_logic := '0';
	signal go_div : std_logic := '1';
	signal zeta_out : unsigned(bits_num-bits_den-1 downto 0);
	constant cycles : integer := 10000;
	constant clk_freq :  time := 10 ns; 
begin
	--mapping the component signals to the one in the test bench (i.e. attaching the
	divider_map:divider
	port map(
	clk => clk,
	num => num,
	den => den,
	go_div => go_div,
	zeta_out => zeta_out
	);
	--process for the clock generation 
	process
	begin 
		for i in 0 to cycles loop
			wait for clk_freq;
			clk <= not clk;
			wait for clk_freq;
			clk <= not clk;
		end loop;
		wait for 1000 ns;	
	end process;
	
	--assignment process
	process
	begin
	
	
	end process;
	
	
	

end BEHAVIORAL;
