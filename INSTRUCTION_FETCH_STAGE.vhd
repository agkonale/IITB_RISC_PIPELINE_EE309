library ieee;
use ieee.std_logic_1164.all;

library work;
use work.General_Components.all;
use work.ALU_Components.all;

entity INSTRUCTION_FETCH_STAGE is
	port(
			clk:		in std_logic;
			reset:		in std_logic;
			
			PC_enable:	in std_logic;
			
			MUX1_Sel:	in std_logic_vector(2 downto 0);
			MUX2_Sel:	in std_logic_vector(1 downto 0);

			L2_1:		in std_logic_vector(15 downto 0);
			L2_8:		in std_logic_vector(15 downto 0);
			L2_9:		in std_logic_vector(15 downto 0);
			L2_11:		in std_logic_vector(7 downto 0);
			
			L3_11:		in std_logic_vector(15 downto 0);
			
			L4_8:		in std_logic_vector(15 downto 0);
			L4_12:		in std_logic_vector(15 downto 0);

			L5_3:		in std_logic_vector(15 downto 0);
			L5_14:		in std_logic_vector(15 downto 0);
			

			L1_2:		out std_logic_vector(15 downto 0);
			L1_3:		out std_logic_vector(15 downto 0);
			L1_5:		out std_logic_vector(15 downto 0)
	     );      
end entity;


architecture Struct of INSTRUCTION_FETCH_STAGE is 
signal L1_1,L1_4,L1_2_temp,L1_3_temp :std_logic_vector(15 downto 0);
signal T1:std_logic;
signal L_M,S_M: std_logic_vector(15 downto 0);
--LM -> 0110 RA 1 --------
--SM -> 0111 RA 1 --------

begin
	L1_2 	<= 	L1_2_temp;
	
	L1_3	<=	L1_3_temp;

	L_M(15 downto 9)	<= 	L2_1(15 downto 9);
	L_M(8)	<= '1';
	L_M(7 downto 0)		<= 	L2_11;
	
	S_M(15 downto 9)	<=	L2_1(15 downto 9);
	S_M(8)	<= '1';
	S_M(7 downto 0)		<= 	L2_11;
	
	
	
	ADDER1:				ADDER_16 port map (A	=>	L1_2_temp,
										   B	=>	"0000000000000001",
	 									   Cin	=>	'0',
			
	 									   RESULT	=>	L1_3_temp,
	 									   Cout		=>	T1);

	
	--ADDER1:				INCREMENTER_16 port map (A	=>	L1_2_temp, RESULT	=>	L1_3_temp);
	
	PROGRAM_MEM:		PROGRAM_MEMORY port map (L1_2_temp(6 downto 0),L1_4);
	
	PC:					DATA_REGISTER 
						generic map(16)
						port map (Din => L1_1 , Dout => L1_2_temp , clk => clk, enable => PC_enable, reset => reset);

	

	L1_1 <=	L1_3_temp	when MUX1_Sel = "111"	else		--PC+1
			L2_8		when MUX1_Sel = "110"  	else		--PC+Imm	JAL,BEQ TAKEN BRANCH HEURISTIC
			L3_11		when MUX1_Sel = "101"  	else		--RB	JLR
			L4_8		when MUX1_Sel = "100"  	else		--BEQ		RA!=RB
			L4_12		when MUX1_Sel = "011"  	else		--Destination => R7 ADD/NAND	RC = R7
			L5_14 		when MUX1_Sel = "010"  	else		--Destination => R7 LW	RA = R7
			L5_3    	when MUX1_Sel = "001"  	else		--ADC,NDC,ADZ,NDZ	RC = R7
			L2_9 ; --000	   							    --LHI	RA = R7
						

	L1_5 <= L_M 	when MUX2_Sel = "00" else	--LM'
			S_M 	when MUX2_Sel = "01" else	--SM'
			L1_4 	when MUX2_Sel = "10" else	--NEXT INSTRUCTION(PROGRAM MEMORY)
			"1111111111111111";	--00			--NOP
			
end Struct;
