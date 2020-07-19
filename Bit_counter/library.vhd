--library initialization for the source file "tower_counter.vhd"

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--declaration of the number of i/o bits
Package Bits is
	constant Bits_in             : integer := 7;
    constant Bits_out             : integer := 3;
end Bits;