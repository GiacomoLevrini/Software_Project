--This source code implements a division between two binary numbers.

-- numeber of bit definition per numerator and denominator
Package Types is 
	constant bits_num  : integer := 8;
	constant bits_den  : integer := 4; 
end Types;

-- usage of the defined package
library work;
use work.Types.all;

-- library inclusion
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Definition of the inputs and outputs of the defined entity
ENTITY DIVIDER is 
	port(
		num : in unsigned(bits_num-1 downto 0); --numerator of the division
		den : in unsigned(bits_den-1 downto 0); --denominator of the division
		clk : in std_logic;  --electronic clock
		zeta_out : out unsigned(bits_num-bits_den-1 downto 0) --output result
	);
end DIVIDER;

ARCHITECTURE BEHAVIORAL of DIVIDER is

-- delcaration of the internal signal of the architecture
signal num_temp : unsigned(bits_num-1 downto 0);
signal den_temp : unsigned(bits_den-1 downto 0);

begin
	
	RUN0 : PROCESS(clk, num, den)
	begin
		--if condition to apply in order to do synchronous operations to the clock rising edge
		if (clk'event and clk='1') then
			num_temp <= num;
			den_temp <= den;	
		end if;
	end PROCESS RUN0;
	
end BEHAVIORAL;