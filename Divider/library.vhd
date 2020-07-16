--library initialization for the source file "divider.vhd"

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Package Bits is
	constant Bits_num             : integer := 31;
    constant Bits_den             : integer := 10;
end Bits;