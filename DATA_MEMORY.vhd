library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.General_Components.all;

entity DATA_MEMORY is
	port(
			clk:		in std_logic;
			reset:		in std_logic;
			
			mem_write:	in std_logic;
			mem_read:	in std_logic;			
			Address:	in std_logic_vector(6 downto 0);
			Din: 		in std_logic_vector(15 downto 0);
			
			Dout: 		out std_logic_vector(15 downto 0)
	     );      
end entity;


architecture Behave of DATA_MEMORY is
--128 short word Data Memory
signal MEM_16X128 : MEM_16(0 to 127):=
								("0000000000000000",
								 "0001001001111111",
								others => "0000000000000000");
								
begin

--Read process
process(Address,mem_read)						
variable Addr_INT :integer range 0 to 127;
begin	
		if(mem_read = '1') then
			Addr_INT 	:= to_integer(unsigned(Address));              
			Dout 		<= MEM_16X128(Addr_INT);  				  					   	
		end if;	

end process;


--Write process
process(clk)						
variable Addr_INT :integer range 0 to 127;	
begin		
	if(clk'event and (clk  = '1')) then
		if(reset='0') then				
			MEM_16X128 <= ( "0011001111111111",
							"0001001001111111",
							others => "0000000000000000");
	
		elsif(mem_write = '1') then   
			Addr_INT 				:= to_integer(unsigned(Address));   
			MEM_16X128 (Addr_INT)	<=  Din ;
		end if;	
	end if;			
end process;

end Behave;


