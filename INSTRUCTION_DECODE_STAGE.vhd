library ieee;
use ieee.std_logic_1164.all;

library work;
use work.General_Components.all;
use work.ALU_Components.all;

entity INSTRUCTION_DECODE_STAGE is
	port(
			L2_1: in std_logic_vector(15 downto 0);
			L2_2: in std_logic_vector(15 downto 0);
			
			L3_1: in std_logic_vector(15 downto 0);
			

			L2_4: out std_logic_vector(16 downto 0);
			L2_5: out std_logic_vector(15 downto 0);	
			L2_8: out std_logic_vector(15 downto 0);	
			L2_9: out std_logic_vector(15 downto 0);
			L2_10: out std_logic_vector(2 downto 0);
			L2_11: out std_logic_vector(7 downto 0)
					
	     );      
end entity;


architecture Struct of INSTRUCTION_DECODE_STAGE is
signal L2_6,L2_7,L2_5_temp:	std_logic_vector(15 downto 0);
signal Cout,MUX3_Sel:	std_logic;
signal L2_10_temp: std_logic_vector(2 downto 0);
begin
	L2_5	<=	L2_5_temp;
	L2_10	<=	L2_10_temp;
					
	ADDER2: 			ADDER_16 port map(L2_7,L2_2,'0',L2_8,Cout);

	SIGN_EXTENDER_6:	SE6 port map(L2_1(5 downto 0),L2_5_temp);
	SIGN_EXTENDER_9:	SE9 port map(L2_1(8 downto 0),L2_6);
	LHI_EXTENDER_9:		LH9 port map(X	=>	L2_1(8 downto 0),Y	=>	L2_9);

											
	PRI_EN: 		PRIORITY_ENCODER port map	(X	=>	L2_1(7 downto 0),	Y	=>	L2_10_temp);

	SPZ:			SET_POS_ZERO port map	(X	=>	L2_1(7 downto 0), 
											POS	=>	L2_10_temp,
					  
											Y	=>	L2_11);
	
	
	--Control Logic Unit
	L2_4 <= "10000001000010010"	when L2_1(15 downto 12) = "0000" else	--ADD,ADC,ADZ
			"10000000000010010"	when L2_1(15 downto 12) = "0010" else	--NDU,NDC,NDZ
			
			"10010001000010001"	when L2_1(15 downto 12) = "0001" else	--ADI
			
			"00000000000011100"	when L2_1(15 downto 12) = "0011" else	--LHI
			
			"10000011010110100"	when L2_1(15 downto 12) = "0100" else	--LW
			
			"10000011001000000"	when L2_1(15 downto 12) = "0101" else	--SW

			"00000000000000000"	when L2_1(15 downto 12) = "0110" and L2_1(8) = '1' and L2_1(7 downto 0) = "00000000" else 	--LM'
			"00110101100110111"	when L2_1(15 downto 12) = "0110" and L2_1(8) = '1'  else	--LM'
			
			"00000000000000000"	when L2_1(15 downto 12) = "0110" and L2_1(7 downto 0) = "00000000" else	--LM
			"00100001100110111"	when L2_1(15 downto 12) = "0110" else	--LM
			
			"00000000000000000"	when L2_1(15 downto 12) = "0111" and L2_1(8) = '1' and L2_1(7 downto 0) = "00000000" else	--SM'
			"00110101101000000"	when L2_1(15 downto 12) = "0111" and L2_1(8) = '1' else	--SM'

			"00000000000000000"	when L2_1(15 downto 12) = "0111" and L2_1(7 downto 0) = "00000000" else	--SM
			"00100001101000000"	when L2_1(15 downto 12) = "0111" else	--SM
			
			"10000000000000000"	when L2_1(15 downto 12) = "1100" else	--BEQ
			
			"00000000000011000"	when L2_1(15 downto 12) = "1000"  else	--JAL
			
			"10000000000011000"	when L2_1(15 downto 12) = "1001" else	--JLR
			
			"00000000000000000"; --*** 
			
			
			
	MUX3_Sel	<=  '0' when L2_1(15 downto 12) = "1100"  else	--BEQ
					'1' ;										--JAL
					

	L2_7 	<=  L2_5_temp when MUX3_Sel = '0' else
		   		L2_6 ;

	
end Struct;
