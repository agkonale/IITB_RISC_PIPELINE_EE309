library ieee;
use ieee.std_logic_1164.all;

library work;
use work.General_Components.all;


entity REGISTER_READ_STAGE is
	port(	clk:	in std_logic;
			reset: 	in std_logic;
			
			L3_1:	in std_logic_vector(15 downto 0);
			L3_2:	in std_logic_vector(16 downto 0);
			L3_4:	in std_logic_vector(15 downto 0);
			L3_6:	in std_logic_vector(2 downto 0);
				
			L4_1:	in std_logic_vector(15 downto 0);
			L4_6:	in std_logic_vector(15 downto 0);
			L4_8:	in std_logic_vector(15 downto 0);
			L4_12:	in std_logic_vector(15 downto 0);
			
			L5_1:	in std_logic_vector(15 downto 0);
			L5_2:	in std_logic_vector(8 downto 0);
			L5_3:	in std_logic_vector(15 downto 0);
			L5_9:	in std_logic_vector(15 downto 0);  
			L5_10:	in std_logic_vector(2 downto 0);  
			L5_11:	in std_logic_vector(15 downto 0);
			L5_12:	in std_logic;
			L5_14:	in std_logic_vector(15 downto 0);
						
			L6_1:	in std_logic_vector(15 downto 0);
			L6_2:	in std_logic_vector(4 downto 0);
			L6_3:	in std_logic_vector(15 downto 0);
			L6_4:	in std_logic_vector(15 downto 0);
			L6_7:	in std_logic_vector(2 downto 0);
			L6_8:	in std_logic_vector(15 downto 0);
			L6_9:	in std_logic_vector(15 downto 0);
			L6_10:	in std_logic_vector(2 downto 0);
			L6_11:	in std_logic_vector(15 downto 0); 
			
			
			L3_10:	out std_logic_vector(15 downto 0);
			L3_11:	out std_logic_vector(15 downto 0);
			
			A1:	out std_logic_vector(2 downto 0);
			A2:	out std_logic_vector(2 downto 0)
			
	     );      
end entity;


architecture Struct of REGISTER_READ_STAGE is
signal	L3_8,L3_9:	std_logic_vector(15 downto 0);
signal  A_1,A_2	:	std_logic_vector(2 downto 0);
signal  M5_Sel,M6_Sel :	std_logic_vector(3 downto 0);
signal  MUX4_Sel: std_logic;


begin

A1	<=	A_1;
A2	<=	A_2;

MUX4_Sel	<= L3_2(16);

REG_FILE: 		REGISTER_FILE port map( clk		=>	clk,
										reset	=>	reset,
										A1		=>	A_1,
										A2		=>	A_2,
										A3		=>	L6_7, 
										D3		=>	L6_8,
										reg_write	=>	L6_2(4),
											 
										D1		=>	L3_8,
										D2		=>	L3_9);
										


A_1	<=	L3_1(11 downto 9);

A_2 <=	L3_1(8 downto 6) when MUX4_Sel = '1' else
	  	L3_6;	   
	  	

L3_10 <=	L4_6		when M5_Sel <= "0000" else
			L5_9		when M5_Sel <= "0001" else
			L6_9		when M5_Sel <= "0010" else
			
			L4_8 		when M5_Sel <= "0011" else
			L5_11		when M5_Sel <= "0100" else
			L6_11 		when M5_Sel <= "0101" else
			
			L4_12 		when M5_Sel <= "0110" else
			L5_3 		when M5_Sel <= "0111" else
			L6_4		when M5_Sel <= "1000" else
			
			L5_14 		when M5_Sel <= "1001" else
			L6_3	 	when M5_Sel <= "1010" else
			
			L3_4		when M5_Sel <= "1011" else
		
			L3_8		when M5_Sel <= "1111" else
			"0000000000000000";

L3_11 <=	L4_6 		when M6_Sel <= "0000" else
			L5_9 		when M6_Sel <= "0001" else
			L6_9		when M6_Sel <= "0010" else
			
			L4_8		when M6_Sel <= "0011" else
			L5_11	 	when M6_Sel <= "0100" else
			L6_11	 	when M6_Sel <= "0101" else
			
			L4_12	 	when M6_Sel <= "0110" else
			L5_3	 	when M6_Sel <= "0111" else
			L6_4	 	when M6_Sel <= "1000" else
			
			L5_14	 	when M6_Sel <= "1001" else
			L6_3		when M6_Sel <= "1010" else
			
			L3_4		when M6_Sel <= "1011" else
	
			L3_9		when M6_Sel <= "1111" else
			"0000000000000000";



--DATA HAZARD DETECTION UNIT   

M5_Sel <= "1011" when A_1 = "111" else	--PC


		  "0000" when L4_1(15 downto 12) = "0011" and  L4_1(11 downto 9) = A_1 else									--LHI result in EX stage
		  
		  "0011" when (L4_1(15 downto 12) = "1000" or L4_1(15 downto 12)= "1001") and L4_1(11 downto 9) = A_1 else	--JAL/JLR result in EX stage
		  
		  "0110" when ((L4_1(15 downto 12) = "0000" or L4_1(15 downto 12) = "0010") and L4_1(5 downto 3) = A_1 and L4_1(1 downto 0) = "00")	--ADD/NDU in EX stage 
		  		 or  (L4_1(15 downto 12) = "0001" and L4_1(8 downto 6) = A_1) else  								--ADI result in EX stage
		  		 
		  		
		  "0001" when L5_1(15 downto 12) = "0011" and  L5_1(11 downto 9) = A_1 else									--LHI result in MA stage
		  
		  "0100" when (L5_1(15 downto 12) = "1000" or L5_1(15 downto 12)= "1001") and  L5_1(11 downto 9) = A_1 else	--JAL/JLR result in MA stage
		  
		  "0111" when ((L5_1(15 downto 12) = "0000" or L5_1(15 downto 12) = "0010") and L5_1(5 downto 3) = A_1 and L5_12 = '1') --ADD/NDU/ADC/NDC/ADZ/NDZ result 																																	in MA stage 
		  
					  or (L5_1(15 downto 12) = "0001" and L5_1(8 downto 6) = A_1) else   	 							--ADI result in MA stage  
					   
					               
		  "1001" when (L5_1(15 downto 12) = "0100" and  L5_1(11 downto 9) = A_1) 									--LW result in MA stage
				 or (L5_1(15 downto 12) = "0110" and  L5_10 = A_1  and L5_2(5) = '1') else							--LM result in MA stage 


		  "0010" when L6_1(15 downto 12) = "0011" and  L6_1(11 downto 9) = A_1 else									--LHI result in WB stage
		  
		  "0101" when (L6_1(15 downto 12) = "1000" or L6_1(15 downto 12)= "1001") and  L6_1(11 downto 9) = A_1 else	--JAL/JLR result in WB stage
		  
		  "1000" when ((L6_1(15 downto 12) = "0000" or L6_1(15 downto 12) = "0010") and L6_1(5 downto 3) = A_1 and L6_2(4) = '1') --ADD/NDU/ADC/NDC/ADZ/NDZ result 																																		in WB stage  
		  
					  or (L6_1(15 downto 12) = "0001" and L6_1(8 downto 6) = A_1)   else                   			--ADI result in WB stage    
					  
		  "1010" when (L6_1(15 downto 12) = "0100" and  L6_1(11 downto 9) = A_1) 									--LW result in WB stage
		  		 or (L6_1(15 downto 12) = "0110" and  L6_10 = A_1 and L6_2(4) = '1') else							--LM result in WB stage

		  "1111";	  




M6_Sel <= "1011" when A_2 = "111" else	--PC


		  "0000" when L4_1(15 downto 12) = "0011" and  L4_1(11 downto 9) = A_2 else									--LHI result in EX stage
		  
		  "0011" when (L4_1(15 downto 12) = "1000" or L4_1(15 downto 12)= "1001") and L4_1(11 downto 9) = A_2 else	--JAL/JLR result in EX stage
		  
		  "0110" when ((L4_1(15 downto 12) = "0000" or L4_1(15 downto 12) = "0010") and L4_1(5 downto 3) = A_2 and L4_1(1 downto 0) = "00")	--ADD/NDU in EX stage 
		  		 or  (L4_1(15 downto 12) = "0001" and L4_1(8 downto 6) = A_2) else  								--ADI result in EX stage
		  		 
		  		
		  "0001" when L5_1(15 downto 12) = "0011" and  L5_1(11 downto 9) = A_2 else									--LHI result in MA stage
		  
		  "0100" when (L5_1(15 downto 12) = "1000" or L5_1(15 downto 12)= "1001") and  L5_1(11 downto 9) = A_2 else	--JAL/JLR result in MA stage
		  
		  "0111" when ((L5_1(15 downto 12) = "0000" or L5_1(15 downto 12) = "0010") and L5_1(5 downto 3) = A_2 and L5_12 = '1') --ADD/NDU/ADC/NDC/ADZ/NDZ result 																																	in MA stage 
		  
					  or (L5_1(15 downto 12) = "0001" and L5_1(8 downto 6) = A_2) else   	 							--ADI result in MA stage  
					   
					               
		  "1001" when (L5_1(15 downto 12) = "0100" and  L5_1(11 downto 9) = A_2) 									--LW result in MA stage
				 or (L5_1(15 downto 12) = "0110" and  L5_10 = A_2  and L5_2(5) = '1') else							--LM result in MA stage 



		  "0010" when L6_1(15 downto 12) = "0011" and  L6_1(11 downto 9) = A_2 else									--LHI result in WB stage
		  
		  "0101" when (L6_1(15 downto 12) = "1000" or L6_1(15 downto 12)= "1001") and  L6_1(11 downto 9) = A_2 else	--JAL/JLR result in WB stage
		  
		  "1000" when ((L6_1(15 downto 12) = "0000" or L6_1(15 downto 12) = "0010") and L6_1(5 downto 3) = A_2 and L6_2(4) = '1') --ADD/NDU/ADC/NDC/ADZ/NDZ result 																																		in WB stage  
		  
					  or (L6_1(15 downto 12) = "0001" and L6_1(8 downto 6) = A_2)   else                   			--ADI result in WB stage    
					  
		  "1010" when (L6_1(15 downto 12) = "0100" and  L6_1(11 downto 9) = A_2) 									--LW result in WB stage
		  		 or (L6_1(15 downto 12) = "0110" and  L6_10 = A_2 and L6_2(4) = '1') else							--LM result in WB stage

		  "1111";	  

		  		  
end Struct;
