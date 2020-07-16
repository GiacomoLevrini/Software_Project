--This source code implements a bit counter 

--library delcaration
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--bit couter implementation 
ENTITY tower_counter is 
	port(
	clk : in std_logic;
	input: in std_logic_vector (7 downto 0);
	output : out std_logic_vector(2 dowto 0)
	);
end tower_counter;

ARCHITECTURE Behavioral of tower_counter is

begin

end Behavioral;
	



