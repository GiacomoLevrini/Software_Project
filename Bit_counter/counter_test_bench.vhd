--Test bench for the tower_counter source file
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.uniform;

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
		input: in unsigned;
		output : out UNSIGNED
		);
	end component;
	
	--signal "internal" declaration
	signal clk : std_logic := '0';
	signal input : unsigned(Bits_in downto 0);
	signal output : unsigned(Bits_out downto 0);
	signal reset : std_logic := '0';
	constant cycles : integer := 10000;
	constant clk_freq :  time := 10 ns; 

	impure function random_unsigned( lenght : integer) return unsigned is
		variable r : real;
		variable u_input : unsigned(lenght  downto 0);
		variable seed1 : integer := 42;  --set seeds for the random genaration
		variable seed2 : integer := 42;
	begin
		for i in u_input'range loop 
			uniform(seed1, seed2, r);
			if r>0.5 then
				u_input(i) := '1' ;
			else 
				u_input(i) := '0' ;
			end if;
		end loop;
		return u_input;
	end function;
	
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
		wait for 1 ms;	
	end process;
	
	--assignement process
	process
	begin
		
		input <= "00111100" after clk_freq;
		
		if (clk'event and clk = '1') then
			input <= random_unsigned(Bits_in) after clk_freq;
		end if;
		
		wait for 1 ms;
	assert false report "Test: OK" severity failure;
	end process;
	
end Behavioral;