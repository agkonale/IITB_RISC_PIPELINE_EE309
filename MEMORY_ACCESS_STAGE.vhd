library ieee;
use ieee.std_logic_1164.all;

library work;
use work.General_Components.all;


entity MEMORY_ACCESS_STAGE is
	port(	clk:	in std_logic;
			reset:		in std_logic;
			
			L5_1:	in std_logic_vector(15 downto 0);
			L5_2:	in std_logic_vector(8 downto 0);
			L5_3:	in std_logic_vector(15 downto 0);
			L5_4:	in std_logic_vector(0 downto 0);
			L5_6:	in std_logic_vector(15 downto 0);
			L5_7:	in std_logic_vector(15 downto 0);
			
			L6_5:	in std_logic;
			L6_6:	in std_logic;


			L5_12:  out std_logic;
			L5_14:	out std_logic_vector(15 downto 0);
			L5_16:	out std_logic_vector(0 downto 0);
			C_Enable: out std_logic;
			Z_Enable: out std_logic	
	     );      
end entity;


architecture Struct of MEMORY_ACCESS_STAGE is
signal L5_15,mem_read,mem_write,MUX9_Sel,MUX10_Sel: std_logic;
signal L5_14_temp,L5_13: std_logic_vector(15 downto 0);

begin

	L5_14	<=	L5_14_temp;

	mem_read	<=	L5_2(5);
	mem_write	<=	L5_2(6);
	MUX9_Sel	<=  L5_2(7);
	MUX10_Sel	<=  L5_2(8);

	DATA_MEM:	DATA_MEMORY port map(clk => clk, reset=> reset, mem_write => mem_write ,mem_read => mem_read,Address => L5_3(6 downto 0) ,Din => L5_13 ,
									 Dout => L5_14_temp );
	
	
	
	--C_Enable Unit
	C_Enable <= '1' when	(L5_1(15 downto 12) = "0000" and L5_1(1 downto 0) = "00") or							--ADD
							(L5_1(15 downto 12) = "0001") or														--ADI
							(L5_1(15 downto 12) = "0000" and (L5_1(1 downto 0) = "10") and L6_6 = '1') or			--ADC
							(L5_1(15 downto 12) = "0000" and L5_1(1 downto 0) = "01" and L6_5 = '1') else			--ADZ
				'0';

				
	--Z_Enable Unit
	Z_Enable <= '1' when	(L5_1(15 downto 12) = "0000" and L5_1(1 downto 0) = "00") or					--ADD
							(L5_1(15 downto 12) = "0001") or												--ADI
							(L5_1(15 downto 12) = "0010") or												--NDU
							
							(L5_1(15 downto 12) = "0000" and L5_1(1 downto 0) = "10" and L6_6 = '1')or		--ADC
							(L5_1(15 downto 12) = "0000" and L5_1(1 downto 0) = "01" and L6_5 = '1')or		--ADZ
							
							(L5_1(15 downto 12) = "0010" and L5_1(1 downto 0) = "10" and L6_6 = '1')or		--NDC
							(L5_1(15 downto 12) = "0010" and L5_1(1 downto 0) = "01" and L6_5 = '1')or		--NDZ
							
							(L5_1(15 downto 12) = "0100") else												--LW
				'0';


	--Reg Write Control Unit
	L5_12	<=	'0' when	(L5_1(15 downto 12) = "0000" and L5_1(1 downto 0) = "10" and L6_6 = '0') or		--ADC
							(L5_1(15 downto 12) = "0000" and L5_1(1 downto 0) = "01" and L6_5 = '0') or		--ADZ		
							(L5_1(15 downto 12) = "0010" and L5_1(1 downto 0) = "10" and L6_6 = '0') or		--NDC
							(L5_1(15 downto 12) = "0010" and L5_1(1 downto 0) = "01" and L6_5 = '0') else	--NDZ
				L5_2(4);				
								
					
	--LW Z_FLAG SET UNIT
	L5_15		<=	'1' when L5_14_temp = "0000000000000000" else
				 	'0';

	
	L5_16(0)	<=  L5_4(0)	when MUX9_Sel ='0' else		--ALU FLAG
					L5_15 ;								--LW FLAG

	L5_13		<=	L5_6 when MUX10_Sel = '0' else		--D1
					L5_7 ;								--D2
	
end Struct;
