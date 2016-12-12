library ieee;  
use ieee.std_logic_1164.all;  
 
entity LH9 is  
	port(	
			X:	in std_logic_vector (8 downto 0); 
	
		  	Y:	out std_logic_vector (15 downto 0)
		 );  
end entity;  

architecture Struct of LH9 is  
begin  
     Y(6 downto 0)	<=  "0000000";
     Y(15 downto 7) <=	X;
     
end Struct; 
