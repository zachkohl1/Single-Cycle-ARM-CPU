-- ******************************************************************
-- * project: adder
-- * filename: ADDER.vhd
-- * author: Zachary Kohlman
-- * date: MSOE Spring Quarter 2022
-- * provides: An adder circuit to increase the program counter
-- ******************************************************************
-- library packages
-- std_logic_1164: 9-valued logic signal voltages
-- numeric_std: unsigned, type conversions

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- IO
entity ADDER is
	port(	A, B: in unsigned(31 downto 0);
			S: out unsigned(31 downto 0)
		  );
end entity ADDER;

architecture BEHAV of ADDER is
begin
-- Increasing S by A + B
	S <= A + B;
	
end architecture BEHAV;