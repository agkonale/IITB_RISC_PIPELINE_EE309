library ieee;
use ieee.std_logic_1164.all;

package ALU_Components is
  
	component FULL_ADDER is
		port(
				A:		in std_logic;
				B: 		in std_logic;
				Cin:	in std_logic; 
				
				S: 		out std_logic;
				Cout: 	out std_logic
			);
	end component;

	component ADDER_16 is
   		port(
				A:		in std_logic_vector(15 downto 0); 
				B:		in std_logic_vector(15 downto 0); 
		   		Cin:	in std_logic; 
		   		
		   		RESULT:	out std_logic_vector(15 downto 0); 
		   		Cout:	out std_logic
   			);
	end component;

	component ALU is
	port(
			 OP_Sel:		in std_logic;			 
			 X0:			in std_logic_vector(15 downto 0);
			 X1:			in std_logic_vector(15 downto 0);			 			 
			
			 Y:				out std_logic_vector(15 downto 0);			  
			 C_FLAG:		out std_logic;	 
			 Z_FLAG:		out std_logic
			 
		 );
	end component;
	
end ALU_Components;
