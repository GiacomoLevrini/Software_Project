--This source code implements a division between two binary numbers.

-- usage of the defined package
library work;
use work.Bits.all;

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
		go_div: in std_logic;
		zeta_out : out unsigned(bits_num-bits_den-1 downto 0) --output result
	);
end DIVIDER;

ARCHITECTURE BEHAVIORAL of DIVIDER is

-- delcaration of the internal signal of the architecture
signal num_temp : unsigned(bits_num-1 downto 0);
signal den_temp : unsigned(bits_den-1 downto 0);

begin
	
	RUN0 : PROCESS(clk, num, den)
	--process for premliminar assignement of the signals
	begin
		--if condition to apply in order to do synchronous operations to the clock rising edge
		if (clk'event and clk='1') then
			if (go_div = '1') then  
				--simple assignement of the input signals to the internal signals
				num_temp <= num;
				den_temp <= den;	
			end if;
		end if;
	end PROCESS RUN0;
	
	RUN1 : PROCESS(num_temp, den_temp)
	
	--use some local variables (which are different from signals) to assign temporary results 
	variable div_temp : unsigned(bits_num - (bits_num-bits_den)+1-1 downto 0);   --_temp = temporary
	variable div_out : unsigned(bits_num - bits_den -1 downto 0);		--stores the result to be put in output
	
	begin
		-- div_temp in assigned to slices of num_temp (easy handle the division in column)
		div_temp := num_temp(bits_num-1 downto bits_num-bits_den-1);
		
		--for loop on the bits of the div_temp variable, iterate up to 19 bits
		for i in 0 to bits_num-bits_den-1-1 loop
			-- comparison between the numerator and denominator values
			if (div_temp >= '0' & den_temp) then 
				-- usual operation of the division in column
				div_temp := div_temp - den_temp;	
				div_out(bits_num-bits_den-1-i) := '1';
			else
				div_out(bits_num-bits_den-1-i) := '0';
			end if;
			div_temp(bits_num - (bits_num-bits_den)+1-1 downto 1) := div_temp(bits_den-1 downto 0);
			div_temp(0) := num_temp(bits_num-bits_den-1-1-i); 
			end loop;
			
			--same as in the for loop, but for the 20th bit is done apart
			if (div_temp >= '0' & den_temp) then 
				div_out(0) := '1';
				div_temp := div_temp-den_temp;
			else
				div_out(0) := '0';
				div_temp(bits_num - (bits_num-bits_den)+1-1 downto 1) := div_temp(bits_den-1 downto 0);
				div_temp(0) := '0'; 
			end if;
			
			if(div_temp) >= ('0' & den_temp(bits_den-1 downto 1)) then
				div_out := div_out + "1";
			end if;
			
		zeta_out <= div_out;
	end PROCESS RUN1;
	
	
end BEHAVIORAL;