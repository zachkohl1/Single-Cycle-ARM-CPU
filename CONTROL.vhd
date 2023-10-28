-- ******************************************************************
-- * project: CONTROL
-- * filename: CONTROL.vhd
-- * author: Zachary Kohlman
-- * date: MSOE Spring Quarter 2022
-- * provides: A controller to decide the behvior of the components
-- * of the processor
-- ******************************************************************
-- library packages
-- std_logic_1164: 9-valued logic signal voltages
-- numeric_std: unsigned, type conversions

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- IO
entity CONTROL is
	port(	IBUS: in std_logic_vector(31 downto 20);
			BIT4, C, V, N, Z: in std_logic;
			PCSEL, A3SEL, ROTSEL, SHAMTSEL, SRC2SEL,
			REGWR, CPSRWR, MEMWR, MEMRD, WD4SEL: out std_logic;
			ALUS: out std_logic_vector(2 downto 0)
			);

end entity CONTROL;


architecture STRUCT of CONTROL is
-- Signals to be used in output logic

	signal COND: std_logic_vector(3 downto 0) := IBUS(31 downto 28);
	signal 	OP: std_logic_vector(1 downto 0) := IBUS(27 downto 26);
	signal	 I: std_logic := IBUS(25);
	signal  CMD: std_logic_vector(3 downto 0) := IBUS(24 downto 21);
	signal 	 S: std_logic := IBUS(20);
	signal IBAR: std_logic := IBUS(25);
	signal 	 P: std_logic := IBUS(24);
	signal 	 U: std_logic := IBUS(23);
	signal    B: std_logic := IBUS(22);
	signal	 W: std_logic := IBUS(21);
	signal 	 L: std_logic := IBUS(20);
	signal PUBW:std_logic_vector(3 downto 0) := P & U & B & W;
	signal 	BRANCHL: std_logic := IBUS(24);

	
	begin
		
	ALUS    <= 
		B"000" when (COND = X"E" and OP = B"00" and CMD = B"0100")	-- add inst.
				 or   (COND = X"E" and OP = B"01") or 
					   (COND = X"E" and OP = B"10") 
				else
		B"001" when (COND = X"E" and OP = B"00" and CMD = B"1010")  -- sub inst.
				 or 	(COND = X"E" and OP = B"00" and CMD = B"0010") 
				else 
		B"010" when (COND = X"E" and OP = B"00" and CMD = B"0000")  -- and inst
				else 
		B"011" when (COND = X"E" and OP = B"00" and CMD = B"1100")  -- or inst.
				else 
		B"100" when (COND = X"E" and OP = B"00" and CMD = B"0001")  -- eor inst.
				else
		B"110" when (COND = X"E" and OP = B"00" and CMD = B"1101")  -- b inst.
				else
		B"111" when (COND = X"E" and OP = B"00" and CMD = B"1111"); -- not b. inst
				
	PCSEL    <= 
		'0' when (COND = X"E" and OP = B"10" and BRANCHL = '0') 
				or (COND = X"0" and OP = B"10" and BRANCHL = '0'
				and Z = '1') 
				or (COND = X"1" and OP = B"10" and BRANCHL = '0'
				and Z = '0') 
				else '1';
								
	ROTSEL    <= 
		'1' when (COND = X"E" and OP = B"01" and IBAR = '0') 
			 else '0';												 -- LDR/STR by imm.

	CPSRWR    <= 
		'0' when (OP = B"00" and S = '1') 					 -- When 's' and data proc.
			 else '1';

	SHAMTSEL  <=  
		'1' when (COND = X"E" and OP = B"00" and I = '0' and S = '0'
			 and BIT4 = '1') 										 -- shifted register
			 or (COND = X"0000" and OP = B"00" and I = '0' and S = '1' 
			 and BIT4 = '1') else '0';							 
								  
	 
	SRC2SEL  <= 
		'1' when (OP = B"01" and L = '1' and IBAR = '0') -- LDR Rd, [Rn, #8] 
			 or (OP = B"01" and L = '0' and IBAR = '1')   -- STR RD, [Rn, #8]
			 or (OP = B"00" and I = '1') else '0';			 -- Data Proc. with imm.
	
	MEMWR    <= 
		'0' when (OP = B"01" and L = '0') 					 -- LDR/STR instructions
			 else '1';
	
	MEMRD    <= 
		'0' when (OP = B"01" and L = '1') 					 -- LDR/STR instructions
			 else '1';
	
	WD4SEL   <= 
		'0' when (OP = B"01") 									 -- LDR/STR instructions
			 else '1';
	
	A3SEL		<= 
		'1' when (OP = B"01" and L = '0') 					 -- Only '1' on Str
			 else '0';
	
	REGWR		<= 
		'1' when (COND = X"E" and OP = B"00" and CMD = B"1010"
			 and S = '1')											 -- CMP instructions
			 or (COND = X"E" and OP = B"01" and L = '0')  -- STR instructions
			 or (OP = B"10")										 -- Branch instructions
			 else '0';




end architecture STRUCT;