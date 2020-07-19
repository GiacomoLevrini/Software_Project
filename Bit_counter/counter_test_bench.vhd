--Test bench for the tower_counter source file
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- usage of the defined package
library work;
use work.Bits.all;

ENTITY counter_test_bench is 
-- port(); --port (); is empty in this section because it is already defined in the source
end counter_test_bench;

ARCHITECTURE Behavioral of counter_test_bench is

	component tower_counter
		port(
		clk : in std_logic;
		input: in std_logic_vector;
		output : out std_logic_vector
		);
	end component;
	
	--signal "internal" declaration
	signal clk : std_logic := '0';
	signal input : std_logic_vector(Bits_in downto 0);
	signal output : std_logic_vector(Bits_out downto 0);
	signal input_r :  unsigned(Bits_in downto 0);
	constant cycles : integer := 10000;
	constant clk_freq :  time := 10 ns; 
begin 
	
	counter_map:tower_counter
	port map(
	clk => clk,
	input => input,
	output => output
	);
	
	--process for the clock generation 
	process
	begin 
	
		for i in 0 to cycles loop
			wait for clk_freq/2;
			clk <= not clk;
			wait for clk_freq/2;
			clk <= not clk;
		end loop;
		wait for 1000 ns;	
	end process;
	
	--assignement 
	process
	variable reset : integer range 0 to 1 := 0;
	
	begin
		input_r <= (others=>'0');
		input <= std_logic_vector(input_r);
		reset := 0;
		 case reset is 
			when 0 => for i in Bits_in-4 to Bits_in-2 loop
									if (input_r(i) = '1') then
										reset := 1;
									else 
										input_r <= input_r + 1; 
										input <= std_logic_vector(input_r);
									end if;
								end loop;
			when 1 => 
								input_r <= (others=>'0');
								input <= std_logic_vector(input_r);
								reset := 0;
		end case;
		wait for 1 ms;
		assert false report "Test: OK" severity failure;
	end process;
	
end Behavioral;