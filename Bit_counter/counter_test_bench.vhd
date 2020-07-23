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
		output : out unsigned;
		bit_0 : out unsigned(Bits_out downto 0);
		bit_1 : out unsigned(Bits_out downto 0);
		bit_2 : out unsigned(Bits_out downto 0);
		bit_3 : out unsigned(Bits_out downto 0);
		bit_4 : out unsigned(Bits_out downto 0);
		bit_5 : out unsigned(Bits_out downto 0);
		bit_6 : out unsigned(Bits_out downto 0);
		bit_7 : out unsigned(Bits_out downto 0)
		);
	end component;
	
	--signal "internal" declaration
	signal clk : std_logic := '0';
	signal input : unsigned(Bits_in downto 0);
	signal output : unsigned(Bits_out downto 0);
	signal bit_position : array_test := (others => (others => '0'));
	signal bit_0 : unsigned(Bits_out downto 0) := (others =>'0');
	signal bit_1 : unsigned(Bits_out downto 0) := (others =>'0') ;
	signal bit_2 : unsigned(Bits_out downto 0) := (others =>'0') ;
	signal bit_3 : unsigned(Bits_out downto 0) := (others =>'0') ; 
	signal bit_4 : unsigned(Bits_out downto 0) := (others =>'0') ;
	signal bit_5 : unsigned(Bits_out downto 0) := (others =>'0') ;
	signal bit_6 : unsigned(Bits_out downto 0) := (others =>'0') ;
	signal bit_7 : unsigned(Bits_out downto 0) := (others =>'0') ;
	constant cycles : integer := 10000;
	constant clk_freq :  time := 10 ns; 
	signal seed_1 : integer := 0;
	signal seed_2 : integer := 0;
	
	impure function random_unsigned( lenght : integer; seed_1_f : integer ; seed_2_f : integer ) return unsigned is
		variable r : real;
		variable seed1 : integer := seed_1_f;  --set seeds for the random genaration
		variable seed2 : integer := seed_2_f; 
		variable u_input : unsigned(lenght  downto 0);
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
	output => output,
	bit_0 => bit_0,
	bit_1 => bit_1,
	bit_2 => bit_2,
	bit_3 => bit_3,
	bit_4 => bit_4,
	bit_5 => bit_5,
	bit_6 => bit_6,
	bit_7 => bit_7
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
	
	--seed assignment process per clock period
	process(clk)
	begin
		if(clk'event and clk ='1') then 
			seed_1 <= seed_1 + 1;
			seed_2 <= seed_2 + 2;
		end if;
	end process;
			
	--assignement process
	process
	begin
		while (seed_1 < 1000 and seed_2 < 2000) loop 
			if (( seed_1 rem 10 )=0) then
				input <= "00111100";
				wait for clk_freq;
			else 
				input <= random_unsigned(Bits_in, seed_1, seed_2);
				wait for clk_freq;
			end if;
		end loop;
		wait for 1 us;
	assert false report "Test: OK" severity failure;
	end process;
	
end Behavioral;