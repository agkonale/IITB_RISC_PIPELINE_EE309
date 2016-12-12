library ieee;
use ieee.std_logic_1164.all;

library work;
use work.ALU_Components.all;
use work.General_Components.all;

entity ALU is
	port(
			 OP_Sel:		in std_logic;			 
			 X0:			in std_logic_vector(15 downto 0);
			 X1:			in std_logic_vector(15 downto 0);			 			 
			
			 Y:				out std_logic_vector(15 downto 0);			  
			 C_FLAG:		out std_logic;	 
			 Z_FLAG:		out std_logic
			 
		 );
end entity;


architecture Struct of ALU is

	signal ADD_RESULT,RESULT:std_logic_vector(15 downto 0);
	
	signal C_Sig,Z_Sig: std_logic;
	signal GND: std_logic := '0';
	
	begin

		ADD1: 	ADDER_16 port map(X0,X1,GND,ADD_RESULT,C_Sig);
		

		RESULT			<=	ADD_RESULT when OP_Sel = '1'   else
				  			(X0 NAND X1) when OP_Sel = '0' 	else
				  			"1111111111111111"; 

		Z_Sig			<=	'1' when RESULT = "0000000000000000" else
				 			'0';

		
		Y 		<= RESULT;

		C_FLAG 	<= C_Sig;

		Z_FLAG 	<= Z_Sig;
			  
end Struct;
