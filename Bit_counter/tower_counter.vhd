--This source code implements a bit counter 

--library delcaration
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--bit counter implementation 
ENTITY tower_counter is 
	port(
	clk : in std_logic;
	input: in std_logic_vector (7 downto 0);
	output : out std_logic_vector(3 downto 0)
	);
end tower_counter;

ARCHITECTURE Behavioral of tower_counter is

begin
	
	data_conversion : PROCESS(clk)
	variable counter : integer range 0 to 8 := 0;
	
		
	begin 
		--clock rising condition for synchronous operations
		if (clk'event and clk = '1') then
			
			counter := 0;
			for i in 0 to 8-1 loop
				
				--bit count if the ith bit is '1'
				if ( input (i) = '1') then 
					counter := counter + 1;
				end if;	
			end loop;
			--case define the output to assigne depending on the counter value 
			case counter is 
				when 0 => output  <= "0000";
				when 1 => output  <= "0001";
				when 2 => output  <= "0010";
				when 3 => output  <= "0011";
				when 4 => output  <= "0100";
				when 5 => output  <= "0101";
				when 6 => output  <= "0110";
				when 7 => output  <= "0111";
				when 8 => output  <= "1000";
			end case;
			
		end if;			
	end PROCESS; 
	
end Behavioral;
	



