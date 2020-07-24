--This source code implements a bit counter 

--library delcaration
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- usage of the defined package
library work;
use work.Bits.all;

--bit counter implementation 
ENTITY tower_counter is 
	port(
	clk : in std_logic;
	input : in unsigned(Bits_in downto 0);
	output : out unsigned(Bits_out downto 0);
	bit_0 : out unsigned(Bits_out downto 0); --this series of output signals allows to find the position at which the '1' state is fount in the input signal 
	bit_1 : out unsigned(Bits_out downto 0);
	bit_2 : out unsigned(Bits_out downto 0);
	bit_3 : out unsigned(Bits_out downto 0);
	bit_4 : out unsigned(Bits_out downto 0);
	bit_5 : out unsigned(Bits_out downto 0);
	bit_6 : out unsigned(Bits_out downto 0);
	bit_7 : out unsigned(Bits_out downto 0)
	);
end tower_counter;

ARCHITECTURE Behavioral of tower_counter is
signal bit_position : array_test := (others => (others => '0'));
signal zero: array_test := (others => (others => '0')); --definition of a zero array_test used later in the re-initialization of the bit_poistion signal
type status is (working, restart);
signal reset : status := restart;
begin
	bit_0 <= bit_position(0);
	bit_1 <= bit_position(1);
	bit_2 <= bit_position(2);
	bit_3 <= bit_position(3);
	bit_4 <= bit_position(4);
	bit_5 <= bit_position(5);
	bit_6 <= bit_position(6);
	bit_7 <= bit_position(7);
	
	data_conversion : PROCESS(clk)
	
	variable counter : integer := 0;
	
	begin 
		--clock rising condition for synchronous operations
		if (clk'event and clk = '1') then
			--state machine to define the working or reset status of the counter
			case reset is 
			when working => counter := 0;
							if (input = "00111100") then 
								reset <= restart;	
								bit_position <= zero;
							else
								for i in 0 to Bits_in loop	
									--bit count if the ith bit is '1' and register in the bit_position where it's located
									if ( input (i) = '1') then 
										counter := counter + 1;
										bit_position(counter-1) <= to_unsigned(i+1, 4);
									end if;	
								end loop;
								reset <= working;
							end if;
							--state machine which assigns the output depending on the value of counter 
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
								when others => output <= "1111";
							end case;				
			when restart => counter := 0;
							bit_position <= zero;
							if (input = "00111100") then 
								reset <= restart;
							else 
								reset <= working;
							end if;
			end case;	
		end if;			
	end PROCESS; 
	
end Behavioral;
	



