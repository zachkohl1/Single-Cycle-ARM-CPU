-- ******************************************************************
-- * project: reg32
-- * filename: REG32.vhd
-- * author: Zachary Kohlman
-- * date: MSOE Spring Quarter 2022
-- * provides: a 32-bit register for the SEG7DECODE
-- ******************************************************************
-- library packages
-- std_logic_1164: 9-valued logic signal voltages
-- numeric_std: unsigned, type conversions
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity REG32 is
-- IO
	port( D: in std_logic_vector(31 downto 0);
			LD, RST, CLK: in std_logic;
			Q: out std_logic_vector(31 downto 0)
		  );

end entity REG32;

architecture BEHAV of REG32 is 
-- Active low reset and load
begin
	process(CLK, RST)
	begin
		
		if(RST = '0') then 
			Q <= (others => '0'); 
		
		elsif(rising_edge(CLK)) then 
			if(LD = '0') then 
				Q <= D;
			end if;
		end if;
	end process;

end architecture BEHAV;
