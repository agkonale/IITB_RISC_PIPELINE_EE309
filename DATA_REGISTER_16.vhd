library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DATA_REGISTER_16 is
	port(
			clk:	in std_logic;
			reset: 	in std_logic;
			enable: in std_logic;			
			Din: 	in std_logic_vector(15 downto 0);
			
	      	Dout: 	out std_logic_vector(15 downto 0)
	      	
	     );
end entity;


architecture Behave of DATA_REGISTER_16 is
begin
	
	process(clk)
    begin
       if(clk'event and (clk  = '1')) then
       	   if(reset = '0') then
       	   		Dout <= "1111111111111111";
       	   		
           elsif(enable = '1') then           
           		Dout <= Din;           		           
           end if;                            
       end if;          
    end process;
end Behave;

