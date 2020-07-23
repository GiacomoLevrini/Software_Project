-- This test_bech file simulates the "divider.vhd" source file

-- usage of the defined package
library work;
use work.Bits.all;

-- library inclusion
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.uniform;

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
	
	--signal "internal" declaration  
	signal num : unsigned (bits_num-1 downto 0);
	signal den : unsigned (bits_den-1 downto 0);
	signal clk : std_logic := '0';
	signal go_div : std_logic := '1';
	signal zeta_out : unsigned(bits_num-bits_den-1 downto 0);
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
			wait for clk_freq/2;
			clk <= not clk;
			wait for clk_freq/2;
			clk <= not clk;
		end loop;
		wait for 1000 ns;	
	end process;
	
	--seed assignment process per clock period
	process(clk)
	begin
		if(clk'event and clk ='1') then 
			seed_1 <= seed_1 + 1;
			seed_2 <= seed_2 + 2;
		end if;
	end process;
	
	--assignment process
	process
	begin
		
		while (seed_1 < 1000 and seed_2 < 2000) loop 
			if (( seed_1 rem 10 )=0) then
				go_div <= '0';
				num <= (others => '0');
				den <= (others => '0');
				wait for clk_freq;
			else 
				go_div <= '1'; 
				num <= unsigned(random_unsigned(bits_num-1, seed_1, seed_2));
				den <=  unsigned(random_unsigned(bits_den-1, seed_1, seed_2));
				wait for clk_freq;
			end if;
			end loop;
		wait for 1 us; 
		assert false report "Test: OK" severity failure;
	end process;
	
	
	

end BEHAVIORAL;
