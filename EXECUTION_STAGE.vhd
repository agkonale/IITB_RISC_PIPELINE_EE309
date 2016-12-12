library ieee;
use ieee.std_logic_1164.all;

library work;
use work.General_Components.all;
use work.ALU_Components.all;


entity EXECUTION_STAGE is
	port(	L4_1: in std_logic_vector(15 downto 0);
			L4_2: in std_logic_vector(15 downto 0);
			L4_3: in std_logic_vector(15 downto 0);			
			L4_4: in std_logic_vector(15 downto 0);
			L4_5: in std_logic_vector(15 downto 0);
			
			L5_8: in std_logic_vector(15 downto 0);		
			
			
			L4_11: out std_logic;
			L4_12: out std_logic_vector(15 downto 0);
			L4_13: out std_logic_vector(0 downto 0);
			L4_14: out std_logic_vector(0 downto 0)
	     );      
end entity;



architecture Struct of  EXECUTION_STAGE is
signal	MUX7_Sel,MUX8_Sel: std_logic_vector(2 downto 0);
signal	L4_9,L4_10 :std_logic_vector(15 downto 0);

begin

MUX7_Sel	<=	L4_2(12 downto 10);
MUX8_Sel	<=  L4_2(15 downto 13);

ALU_1:		 ALU port map(
			 OP_Sel	=>	L4_2(9),
			 X0	=>	L4_9,
			 X1	=>	L4_10,			 			 
			
			 Y	=>	L4_12,	  
			 C_FLAG	=>	L4_14(0) ,
			 Z_FLAG	=>	L4_13(0));

L4_11	<=	'1' when (L4_4 = L4_5) else
		  	'0';

L4_9	<=	L4_4	when MUX7_Sel = "000" else		--RA
			L4_3	when MUX7_Sel = "001" else		--SE6
			L5_8	when MUX7_Sel = "010" else		--LM',SM'
			"0000000000000000";
			

L4_10	<=	L4_5	when MUX8_Sel = "000" else		--RB
			L4_3	when MUX8_Sel = "001" else		--SE6
			"0000000000000000" when MUX8_Sel = "010" else	--LM,SM
			"0000000000000001" when MUX8_Sel = "011" else	--LM',SM'
			"0000000000000000";
			
end Struct;
