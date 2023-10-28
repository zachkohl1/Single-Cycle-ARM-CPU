-- ******************************************************************
-- * project: pc
-- * filename: PC.vhd
-- * author: Zachary Kohlman
-- * date: MSOE Spring Quarter 2022
-- * provides: a register to remember the current program count
-- ******************************************************************
-- library packages
-- std_logic_1164: 9-valued logic signal voltages
-- numeric_std: unsigned, type conversions
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity PC is
-- IO
	port( D: in std_logic_vector(31 downto 0);
			LD, RST, CLK: in std_logic;
			Q: out std_logic_vector(31 downto 0)
		  );

end entity PC;

architecture BEHAV of PC is 
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
