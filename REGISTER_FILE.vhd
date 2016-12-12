library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.General_Components.all;

entity REGISTER_FILE is
	port(
			clk:		in std_logic;
			reset: 		in std_logic;
			A1:			in std_logic_vector(2 downto 0);
			A2:			in std_logic_vector(2 downto 0);
			A3:			in std_logic_vector(2 downto 0); 
			D3: 		in std_logic_vector(15 downto 0); 
			reg_write: 	in std_logic; 
				 
			D1: 		out std_logic_vector(15 downto 0); 
			D2: 		out std_logic_vector(15 downto 0)
			
		);	 
end entity;

architecture Behave of REGISTER_FILE is
signal REG_16X8 :MEM_16(0 to 7):= (others=>"0000000000000000");
signal GND:std_logic_vector(15 downto 0):= "0000000000000000";
begin

-- D1,D2
M1 : MUX_16_8 port map(X0=>REG_16X8(0),X1=>REG_16X8(1),X2=>REG_16X8(2),X3=>REG_16X8(3),X4=>REG_16X8(4),X5=>REG_16X8(5),X6=>REG_16X8(6),X7=>GND,Sel=>A1,Y=>D1);
M2 : MUX_16_8 port map(X0=>REG_16X8(0),X1=>REG_16X8(1),X2=>REG_16X8(2),X3=>REG_16X8(3),X4=>REG_16X8(4),X5=>REG_16X8(5),X6=>REG_16X8(6),X7=>GND,Sel=>A2,Y=>D2);


--Write Process
write: process(clk)
variable A3_INT :integer range 0 to 7;	
begin	

if(clk'event and (clk  = '1')) then
	if(reset='0') then				
		REG_16X8	<= (others => "0000000000000000");
	
	elsif(reg_write = '1') then 
		A3_INT 				    := to_integer(unsigned(A3));   
		REG_16X8 (A3_INT)		<=  D3 ;	
	end if;
end if;
	
end process;
end Behave;

