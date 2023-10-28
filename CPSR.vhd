-- ******************************************************************
-- * project: CPSR
-- * filename: CPSR.vhd
-- * author: Zachary Kohlman
-- * date: MSOE Spring Quarter 2022
-- * provides: an active low, async. reset register to remember the
-- * output from the ALU
-- ******************************************************************
-- library packages
-- std_logic_1164: 9-valued logic signal voltages
-- numeric_std: unsigned, type conversions

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity CPSR is
	
	port( D3, D2, D1, D0, LD, RST, CLK: in std_logic;
			Q3, Q2, Q1, Q0: out std_logic
		  );

end entity CPSR;

architecture STRUCT of CPSR is 
-- Active low reset and load
begin
	process(CLK, RST)
	begin
-- Forcing values to 0 if RST active
		
		if(RST = '0') then 
			Q3 <= '0';
			Q2 <= '0';
			Q1 <= '0';
			Q0 <= '0';
			
-- Storing inputs
		elsif(rising_edge(CLK)) then 
			if(LD = '0') then 
				Q3 <= D3;
				Q2 <= D2;
				Q1 <= D1;
				Q0 <= D0;
			end if;
			
		end if;
		
	end process;

end architecture STRUCT;
