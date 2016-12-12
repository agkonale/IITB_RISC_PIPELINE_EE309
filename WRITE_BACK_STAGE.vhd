library ieee;
use ieee.std_logic_1164.all;

library work;
use work.General_Components.all;

entity WRITE_BACK_STAGE is
	port(		
			clk:		in std_logic;
			reset:		in std_logic;
			
			L5_5:		in std_logic_vector(0 downto 0);
			L5_16:		in std_logic_vector(0 downto 0);
			
			L6_1:  		in std_logic_vector(15 downto 0);
			L6_2:  		in std_logic_vector(4 downto 0);
			L6_3:  		in std_logic_vector(15 downto 0);
			L6_4:  		in std_logic_vector(15 downto 0);
			L6_9:  		in std_logic_vector(15 downto 0);
			L6_10:  	in std_logic_vector(2 downto 0);
			L6_11:  	in std_logic_vector(15 downto 0);	
			
			C_Enable:	in std_logic;
			Z_Enable:  	in std_logic;


			L6_5:  		out std_logic;
			L6_6:  		out std_logic;
			L6_7:  		out std_logic_vector(2 downto 0);
			L6_8:  		out std_logic_vector(15 downto 0)
			
	     );      
end entity;


architecture Struct of WRITE_BACK_STAGE is
signal MUX11_Sel,MUX12_Sel: std_logic_vector(1 downto 0);
signal L6_5_temp, L6_6_temp: std_logic_vector(0 downto 0);

begin
	MUX11_Sel <= L6_2(1 downto 0);
	MUX12_Sel <= L6_2(3 downto 2);
	--L6_2(4)	<= Reg_Write

	L6_5	<= L6_5_temp(0);
	L6_6	<= L6_6_temp(0);

	--Address
	L6_7	<= 	L6_1(11 downto 9) when MUX11_Sel = "00" else			--RA
				L6_1(8 downto 6) when MUX11_Sel = "01" else				--RB
				L6_1(5 downto 3) when MUX11_Sel = "10" else				--RC
				L6_10 ; --11											--PRIORITY ENCODER
				
	--WB Data
	L6_8	<=  L6_4 when MUX12_Sel = "00" else							--ALU
				L6_3 when MUX12_Sel = "01" else							--DATA MEMORY
				L6_11 when MUX12_Sel = "10" else						--PC+1
				L6_9 ; --11												--LHI
				

	Z_FLAG:	DATA_REGISTER	generic map(1)
							port map (Din => L5_16 , Dout => L6_5_temp , clk => clk, enable => Z_Enable, reset => reset);

	C_FLAG:	DATA_REGISTER	generic map(1)
							port map (Din => L5_5 , Dout => L6_6_temp , clk => clk, enable => C_Enable, reset => reset);

end Struct;
