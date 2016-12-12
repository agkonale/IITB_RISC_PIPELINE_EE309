library ieee;
use ieee.std_logic_1164.all;

library work;
use work.General_Components.all;

entity TOP_LEVEL is
	 port (
	 		clk:		in std_logic;
	 		reset:		in std_logic;

	 		RESULT: out std_logic_vector(15 downto 0)
	 		
	 	   ); 
end entity;


architecture Struct of TOP_LEVEL is

signal L1_2,L1_3,L1_5:	std_logic_vector(15 downto 0);

signal L2_1,L2_2,L2_3,L2_5,L2_6,L2_7,L2_8,L2_9:std_logic_vector(15 downto 0);
signal L2_10:	std_logic_vector(2 downto 0);
signal L2_11:	std_logic_vector(7 downto 0);
signal L2_4:	std_logic_vector(16 downto 0);

signal L3_1,L3_3,L3_4,L3_5,L3_7,L3_8,L3_9,L3_10,L3_11:std_logic_vector(15 downto 0);
signal L3_2: std_logic_vector(16 downto 0);
signal L3_6: std_logic_vector(2 downto 0);
signal A1,A2:std_logic_vector(2 downto 0);

signal L4_1,L4_2,L4_3,L4_4,L4_5,L4_6,L4_8,L4_12:std_logic_vector(15 downto 0);
signal L4_7:std_logic_vector(2 downto 0);
signal L4_11:std_logic;
signal L4_13,L4_14:std_logic_vector(0 downto 0);

signal L5_1,L5_3,L5_6,L5_7,L5_8,L5_9,L5_11,L5_13,L5_14:	std_logic_vector(15 downto 0);
signal L5_2:std_logic_vector(8 downto 0);
signal L5_4,L5_5,L5_16:std_logic_vector(0 downto 0);
signal L5_12:std_logic;
signal L5_10:std_logic_vector(2 downto 0);
signal L5_2_temp:std_logic_vector(4 downto 0);


signal L6_1,L6_3,L6_4,L6_8,L6_9,L6_11:std_logic_vector(15 downto 0);
signal L6_2:std_logic_vector(4 downto 0);
signal L6_5,L6_6,C_Enable,Z_Enable: std_logic;
signal L6_10,L6_7: std_logic_vector(2 downto 0);

signal FLUSH_1,FLUSH_2,FLUSH_3,PC_enable,IF_ID_RR_Enable,IF_ID_reset,ID_RR_reset,RR_EX_reset	:std_logic;
signal MUX1_Sel:	std_logic_vector(2 downto 0);
signal MUX2_Sel:	std_logic_vector(1 downto 0);


begin

RESULT	<=	L4_12;	
  
FLUSH_1	<=	'0' 	when (L2_1(15 downto 12) = "1000") --JAL 
					or 	(L2_1(15 downto 12) = "0100")  --LW	(optimize)

					
		            or 	(L2_1(15 downto 12) = "1001") --JLR
		            or 	(L3_1(15 downto 12) = "1001")
		            
		            or 	(L2_1(15 downto 12) = "1100") --BEQ
		            or	(L4_1(15 downto 12) = "1100" and L4_11 = '0')	--BEQ HEURISTIC MISPREDICTION
		            

					or (L2_1(15 downto 12) = "0001" and L2_1(8 downto 6) = "111")  		--ADI
		            or (L3_1(15 downto 12) = "0001" and L3_1(8 downto 6) = "111") 
		            or (L4_1(15 downto 12) = "0001" and L4_1(8 downto 6) = "111") 

		            
					or (L2_1(15 downto 12) = "0000" and L2_1(1 downto 0) = "00"  and L2_1(5 downto 3) = "111")  		--ADD
		            or (L3_1(15 downto 12) = "0000" and L3_1(1 downto 0) = "00"	 and L3_1(5 downto 3) = "111") 
		            or (L4_1(15 downto 12) = "0000" and L4_1(1 downto 0) = "00"  and L4_1(5 downto 3) = "111")

		            or (L2_1(15 downto 12) = "0000" and L2_1(1 downto 0) = "10"  and L2_1(5 downto 3) = "111")  		--ADC
		            or (L3_1(15 downto 12) = "0000" and L3_1(1 downto 0) = "10"	 and L3_1(5 downto 3) = "111") 
		            or (L4_1(15 downto 12) = "0000" and L4_1(1 downto 0) = "10"  and L4_1(5 downto 3) = "111")
		            or (L5_1(15 downto 12) = "0000" and L5_1(1 downto 0) = "10"  and L5_1(5 downto 3) = "111" and L6_6 = '1') 
		       
		            or (L2_1(15 downto 12) = "0000" and L2_1(1 downto 0) = "01"  and L2_1(5 downto 3) = "111")  		--ADZ
		            or (L3_1(15 downto 12) = "0000" and L3_1(1 downto 0) = "01"	 and L3_1(5 downto 3) = "111") 
		            or (L4_1(15 downto 12) = "0000" and L4_1(1 downto 0) = "01"  and L4_1(5 downto 3) = "111")  
		            or (L5_1(15 downto 12) = "0000" and L5_1(1 downto 0) = "01"  and L5_1(5 downto 3) = "111" and L6_5 = '1') 

		            or (L2_1(15 downto 12) = "0010" and L2_1(1 downto 0) = "00"  and L2_1(5 downto 3) = "111")  		--NDU
		            or (L3_1(15 downto 12) = "0010" and L3_1(1 downto 0) = "00"	 and L3_1(5 downto 3) = "111") 
		            or (L4_1(15 downto 12) = "0010" and L4_1(1 downto 0) = "00"  and L4_1(5 downto 3) = "111") 

		            or (L2_1(15 downto 12) = "0010" and L2_1(1 downto 0) = "10"  and L2_1(5 downto 3) = "111") 			--NDC
		            or (L3_1(15 downto 12) = "0010" and L3_1(1 downto 0) = "10"	 and L3_1(5 downto 3) = "111") 
		            or (L4_1(15 downto 12) = "0010" and L4_1(1 downto 0) = "10"  and L4_1(5 downto 3) = "111")  
		            or (L5_1(15 downto 12) = "0010" and L5_1(1 downto 0) = "10"  and L5_1(5 downto 3) = "111" and L6_6 = '1')  

		            or (L2_1(15 downto 12) = "0010" and L2_1(1 downto 0) = "01"  and L2_1(5 downto 3) = "111")  		--NDZ
		            or (L3_1(15 downto 12) = "0010" and L3_1(1 downto 0) = "01"	 and L3_1(5 downto 3) = "111") 
		            or (L4_1(15 downto 12) = "0010" and L4_1(1 downto 0) = "01"  and L4_1(5 downto 3) = "111") 
		            or (L5_1(15 downto 12) = "0010" and L5_1(1 downto 0) = "01"  and L5_1(5 downto 3) = "111" and L6_5 = '1')   
		            
		            or (L2_1(15 downto 12) = "0100"  and L2_1(11 downto 9) = "111")	--LW
		            or (L3_1(15 downto 12) = "0100"  and L3_1(11 downto 9) = "111") 
		            or (L4_1(15 downto 12) = "0100"  and L4_1(11 downto 9) = "111")  
		            or (L5_1(15 downto 12) = "0100"  and L5_1(11 downto 9) = "111") 

		            or (L2_1(15 downto 12) = "0011" and L2_1(11 downto 9) = "111")	--LHI

					or (L3_1(15 downto 12) = "0110" and L3_6 = "111") 
					or (L4_1(15 downto 12) = "0110" and L4_7 = "111") 
		            or (L5_1(15 downto 12) = "0110" and L5_10 = "111") else	--LM
		            	            
		    '1';
		    

FLUSH_2	<=	'0' when L4_1(15 downto 12) = "1100" and L4_11 = '0' else --BEQ
			'1';




PC_ENABLE	<=	'0' when (L2_1(15 downto 12) = "0100")	--LW

					or ((L2_1(15 downto 12) = "0110" or L2_1(15 downto 12) = "0111") and not (L2_1(7 downto 0) = "00000000"))				--LM/SM
					
					or ((L4_1(15 downto 12) = "0000" and L4_1(1 downto 0) = "10") and (A1 = L4_1(5 downto 3) or A2 = L4_1(5 downto 3))) 	--ADC DATA HAZARD
					
					or ((L4_1(15 downto 12) = "0000" and L4_1(1 downto 0) = "01") and (A1 = L4_1(5 downto 3) or A2 = L4_1(5 downto 3))) 	--ADZ DATA HAZARD
					
					or ((L4_1(15 downto 12) = "0010" and L4_1(1 downto 0) = "10") and (A1 = L4_1(5 downto 3) or A2 = L4_1(5 downto 3))) 	--NDC DATA HAZARD
					
					or ((L4_1(15 downto 12) = "0010" and L4_1(1 downto 0) = "01") and (A1 = L4_1(5 downto 3) or A2 = L4_1(5 downto 3)))  	--NDZ DATA HAZARD

--
					or (L2_1(15 downto 12) = "0000" and L2_1(1 downto 0) = "10"  and L2_1(5 downto 3) = "111")  		--ADC
		        	or (L3_1(15 downto 12) = "0000" and L3_1(1 downto 0) = "10"	 and L3_1(5 downto 3) = "111") 
		            or (L4_1(15 downto 12) = "0000" and L4_1(1 downto 0) = "10"  and L4_1(5 downto 3) = "111")
		       
		        
		         	or (L2_1(15 downto 12) = "0000" and L2_1(1 downto 0) = "01"  and L2_1(5 downto 3) = "111")  		--ADZ
		            or (L3_1(15 downto 12) = "0000" and L3_1(1 downto 0) = "01"	 and L3_1(5 downto 3) = "111") 
		            or (L4_1(15 downto 12) = "0000" and L4_1(1 downto 0) = "01"  and L4_1(5 downto 3) = "111")  
		        

		          	or (L2_1(15 downto 12) = "0010" and L2_1(1 downto 0) = "10"  and L2_1(5 downto 3) = "111") 			--NDC
		            or (L3_1(15 downto 12) = "0010" and L3_1(1 downto 0) = "10"	 and L3_1(5 downto 3) = "111") 
		            or (L4_1(15 downto 12) = "0010" and L4_1(1 downto 0) = "10"  and L4_1(5 downto 3) = "111")  
		      

		            or (L2_1(15 downto 12) = "0010" and L2_1(1 downto 0) = "01"  and L2_1(5 downto 3) = "111")  		--NDZ
		            or (L3_1(15 downto 12) = "0010" and L3_1(1 downto 0) = "01"	 and L3_1(5 downto 3) = "111") 
		            or (L4_1(15 downto 12) = "0010" and L4_1(1 downto 0) = "01"  and L4_1(5 downto 3) = "111") else
		       
		        
										
				'1';


				         
MUX1_Sel	<=	"110" when L2_1(15 downto 12) = "1000" or L2_1(15 downto 12) = "1100" else	--JAL,BEQ TAKEN BRANCH HEURISTIC	(L2_8)

				"101" when L3_1(15 downto 12) = "1001" else	--JLR	(L3_11)
				
				"100" when L2_1(15 downto 12) = "1100" and L4_11 = '0' else	--BEQ MISPREDICTION	(L4_8)
				
				"011" when (L4_1(15 downto 12) = "0000" and L4_1(1 downto 0) = "00"  and L4_1(5 downto 3) = "111")  or	--ADD	(L4_12)
					  (L4_1(15 downto 12) = "0010" and L4_1(1 downto 0) = "00"  and L4_1(5 downto 3) = "111")  or		--NDU
					  (L4_1(15 downto 12) = "0001" and L4_1(8 downto 6) = "111")  else									--ADI


				"010" when (L5_1(15 downto 12) = "0100" and L5_1(11 downto 9) = "111")	or 	--LW (L5_8)
					  (L5_1(15 downto 12) = "0110" and L5_10 = "111") else	--LM
				
				"001" when (L5_1(15 downto 12) = "0000" and L5_1(1 downto 0) = "10"  and L5_1(5 downto 3) = "111" and L6_6 = '1') or --ADC	(L5_3)
					  (L5_1(15 downto 12) = "0000" and L5_1(1 downto 0) = "01"  and L5_1(5 downto 3) = "111" and L6_5 = '1') or		 --ADZ
					  (L5_1(15 downto 12) = "0010" and L5_1(1 downto 0) = "10"  and L5_1(5 downto 3) = "111" and L6_6 = '1') or		 --NDC
					  (L5_1(15 downto 12) = "0010" and L5_1(1 downto 0) = "01"  and L5_1(5 downto 3) = "111" and L6_5 = '1') else 	 --NDZ
					  
					    
				"000" when (L2_1(15 downto 12) = "0011" and L2_1(11 downto 9) = "111")	else	--LHI	(L2_9)
										
				"111";	--PC+1 (L1_3)
				

MUX2_Sel<=	"00"	when (L2_1(15 downto 12) = "0110" and  not (L2_1(7 downto 0) = "00000000"))	else 	--INSERT LM' 
					
		  	"01"	when (L2_1(15 downto 12) = "0111") and  not (L2_1(7 downto 0) = "00000000") else	--INSERT SM' 
		  			
		  	"10";	--NEXT INSTRUCTION
			
					
IF_Stage:	INSTRUCTION_FETCH_STAGE port map(
												clk			=>	clk,
												reset		=>	reset,
		
												PC_enable	=>	PC_enable,
		
												MUX1_Sel	=>	MUX1_Sel,
												MUX2_Sel	=>	MUX2_Sel,

												L2_1		=>	L2_1,
												L2_8		=>	L2_8,
												L2_9		=>	L2_9,
												L2_11		=>	L2_11,
		
												L3_11		=>	L3_11,
		
												L4_8		=>	L4_8,
												L4_12		=>	L4_12,
												
												L5_3		=>	L5_3,
												L5_14		=>	L5_14,

		
												L1_2		=>	L1_2,
												L1_3		=>	L1_3,
												L1_5		=>	L1_5
												);


IF_ID_RR_Enable <= '0'
	when 	((L4_1(15 downto 12) = "0000" and L4_1(1 downto 0) = "10") and (A1 = L4_1(5 downto 3) or A2 = L4_1(5 downto 3))) --ADC DATA HAZARD
						
	or 		((L4_1(15 downto 12) = "0000" and L4_1(1 downto 0) = "01") and (A1 = L4_1(5 downto 3) or A2 = L4_1(5 downto 3))) --ADZ DATA HAZARD
							
	or 		((L4_1(15 downto 12) = "0010" and L4_1(1 downto 0) = "10") and (A1 = L4_1(5 downto 3) or A2 = L4_1(5 downto 3))) --NDC DATA HAZARD
							
	or 		((L4_1(15 downto 12) = "0010" and L4_1(1 downto 0) = "01") and (A1 = L4_1(5 downto 3) or A2 = L4_1(5 downto 3))) else --NDZ DATA HAZARD
					 
		   			'1';


IF_ID_reset	<=	reset and FLUSH_1;	

--IF/ID registers

IF_ID_1:	DATA_REGISTER_16	port map (Din => L1_5 , Dout => L2_1 ,clk => clk, enable => IF_ID_RR_Enable, reset => IF_ID_reset );
							
IF_ID_2:	DATA_REGISTER	generic map(16)
							port map (Din => L1_2 , Dout => L2_2 , clk => clk, enable => IF_ID_RR_Enable, reset => reset);
							
IF_ID_3:	DATA_REGISTER	generic map(16)
							port map (Din => L1_3 , Dout => L2_3 , clk => clk, enable => IF_ID_RR_Enable, reset => reset);
							
ID_Stage:	INSTRUCTION_DECODE_STAGE port map(
												L2_1	=>	L2_1,
												L2_2	=>	L2_2,
			
												L3_1	=>	L3_1,

													
												L2_4	=>	L2_4,
												L2_5	=>	L2_5,	
												L2_8	=>	L2_8,
												L2_9	=>	L2_9,
												L2_10	=>	L2_10,
												L2_11	=>	L2_11
					
												);





--ID/RR registers		
ID_RR_reset	<= reset and FLUSH_2;
					
ID_RR_1:	DATA_REGISTER_16	port map (Din => L2_1 , Dout => L3_1 , clk => clk, enable => IF_ID_RR_Enable, reset => ID_RR_reset);

ID_RR_2:	DATA_REGISTER	generic map(17)
							port map (Din => L2_4 , Dout => L3_2 , clk => clk, enable => IF_ID_RR_Enable, reset => ID_RR_reset);

ID_RR_3:	DATA_REGISTER	generic map(16)
							port map (Din => L2_5 , Dout => L3_3 , clk => clk, enable => IF_ID_RR_Enable, reset => reset);

ID_RR_4:	DATA_REGISTER	generic map(16)
							port map (Din => L2_2 , Dout => L3_4 , clk => clk, enable => IF_ID_RR_Enable, reset => reset);

ID_RR_5:	DATA_REGISTER	generic map(16)
							port map (Din => L2_9 , Dout => L3_5 , clk => clk, enable => IF_ID_RR_Enable, reset => reset);

ID_RR_6:	DATA_REGISTER	generic map(3)
							port map (Din => L2_10 , Dout => L3_6 , clk => clk, enable => IF_ID_RR_Enable, reset => reset);

ID_RR_7:	DATA_REGISTER	generic map(16)
							port map (Din => L2_3 , Dout => L3_7 , clk => clk, enable => IF_ID_RR_Enable, reset => reset);



RR_Stage:	REGISTER_READ_STAGE port map(	
											clk		=>  clk,
											reset	=>	reset,
											
											L3_1	=>	L3_1,
											L3_2	=>	L3_2,
											L3_4	=>	L3_4,
											L3_6	=>	L3_6,

											L4_1	=>	L4_1,
											L4_6	=>	L4_6,
											L4_8	=>	L4_8,
											L4_12	=>	L4_12,

											L5_1	=>	L5_1,
											L5_2	=>	L5_2,
											L5_3	=>	L5_3,
											L5_9	=>	L5_9,
											L5_10	=>	L5_10,
											L5_11	=>	L5_11,
											L5_12	=>	L5_12,
											L5_14	=>	L5_14,

											
											L6_1	=>	L6_1,
											L6_2	=>	L6_2,
											L6_3	=>	L6_3,
											L6_4	=>	L6_4,
											L6_7	=>	L6_7,
											L6_8	=>	L6_8,
											L6_9	=>	L6_9,
											L6_10	=>	L6_10,
											L6_11	=>	L6_11,

											L3_10	=>	L3_10,
											L3_11	=>	L3_11,
											
											A1		=>	A1,
											A2		=>	A2
										);



--RR/EX registers
RR_EX_reset	<= reset and FLUSH_3;

FLUSH_3	<= '0' 
	when 	((L4_1(15 downto 12) = "0000" and L4_1(1 downto 0) = "10") and (A1 = L4_1(5 downto 3) or A2 = L4_1(5 downto 3))) --ADC DATA HAZARD
						
	or 		((L4_1(15 downto 12) = "0000" and L4_1(1 downto 0) = "01") and (A1 = L4_1(5 downto 3) or A2 = L4_1(5 downto 3))) --ADZ DATA HAZARD
							
	or 		((L4_1(15 downto 12) = "0010" and L4_1(1 downto 0) = "10") and (A1 = L4_1(5 downto 3) or A2 = L4_1(5 downto 3))) --NDC DATA HAZARD
							
	or 		((L4_1(15 downto 12) = "0010" and L4_1(1 downto 0) = "01") and (A1 = L4_1(5 downto 3) or A2 = L4_1(5 downto 3))) else --NDZ DATA HAZARD
		'1';


RR_EX_1:	DATA_REGISTER_16	port map (Din => L3_1 , Dout => L4_1 , clk => clk, enable => '1', reset => RR_EX_reset);

RR_EX_2:	DATA_REGISTER	generic map(16)
							port map (Din => L3_2(15 downto 0) , Dout => L4_2 , clk => clk, enable => '1', reset => RR_EX_reset);

RR_EX_3:	DATA_REGISTER	generic map(16)
							port map (Din => L3_3 , Dout => L4_3 , clk => clk, enable => '1', reset => reset);

RR_EX_4:	DATA_REGISTER	generic map(16)
							port map (Din => L3_10 , Dout => L4_4 , clk => clk, enable => '1', reset => reset);

RR_EX_5:	DATA_REGISTER	generic map(16)
							port map (Din => L3_11 , Dout => L4_5 , clk => clk, enable => '1', reset => reset);

RR_EX_6:	DATA_REGISTER	generic map(16)
							port map (Din => L3_5 , Dout => L4_6 , clk => clk, enable => '1', reset => reset);

RR_EX_7:	DATA_REGISTER	generic map(3)
							port map (Din => L3_6 , Dout => L4_7 , clk => clk, enable => '1', reset => reset);

RR_EX_8:	DATA_REGISTER	generic map(16)
							port map (Din => L3_7 , Dout => L4_8 , clk => clk, enable => '1', reset => reset);


EX_Stage:	EXECUTION_STAGE port map(
										
										L4_1	=>	L4_1,
										L4_2	=>	L4_2,
										L4_3	=>	L4_3,			
										L4_4	=>	L4_4,
										L4_5	=>	L4_5,

										L5_8	=>	L5_8,	
										
			
										L4_11	=>	L4_11,
										L4_12	=>	L4_12,
										L4_13	=>	L4_13,
										L4_14	=>	L4_14
									);



--EX/MA registers
EX_MA_1:	DATA_REGISTER_16	port map (Din => L4_1 , Dout => L5_1 , clk => clk, enable => '1', reset => reset);
							
EX_MA_2:	DATA_REGISTER	generic map(9)
							port map (Din => L4_2(8 downto 0) , Dout => L5_2 , clk => clk, enable => '1', reset => reset);
							
EX_MA_3:	DATA_REGISTER	generic map(16)
							port map (Din => L4_12 , Dout => L5_3 , clk => clk, enable => '1', reset => reset);
							
EX_MA_4:	DATA_REGISTER	generic map(1)
							port map (Din => L4_13 , Dout => L5_4 , clk => clk, enable => '1', reset => reset);
							
EX_MA_5:	DATA_REGISTER	generic map(1)
							port map (Din => L4_14 , Dout => L5_5 , clk => clk, enable => '1', reset => reset);
							
EX_MA_6:	DATA_REGISTER	generic map(16)
							port map (Din => L4_4 , Dout => L5_6 , clk => clk, enable => '1', reset => reset);

EX_MA_7:	DATA_REGISTER	generic map(16)
							port map (Din => L4_5, Dout => L5_7 , clk => clk, enable => '1', reset => reset);
							
EX_MA_8:	DATA_REGISTER	generic map(16)
							port map (Din => L4_12 , Dout => L5_8 , clk => clk, enable => '1', reset => reset);

EX_MA_9:	DATA_REGISTER	generic map(16)
							port map (Din => L4_6 , Dout => L5_9 , clk => clk, enable => '1', reset => reset);

EX_MA_10:	DATA_REGISTER	generic map(3)
							port map (Din => L4_7, Dout => L5_10 , clk => clk, enable => '1', reset => reset);

EX_MA_11:	DATA_REGISTER	generic map(16)
							port map (Din => L4_8, Dout => L5_11 , clk => clk, enable => '1', reset => reset);



							
MA_Stage: 	MEMORY_ACCESS_STAGE port map(   clk		=>	clk,
											reset	=>	reset,
											
											L5_1	=>	L5_1,
											L5_2	=>	L5_2,
											L5_3	=>	L5_3,
											L5_4	=>	L5_4,
											L5_6	=>	L5_6,
											L5_7	=>	L5_7,
											
											L6_5	=>	L6_5,
											L6_6	=>	L6_6,

			
											L5_12	=>	L5_12,
											L5_14	=>	L5_14,
											L5_16	=>	L5_16,
											
											C_Enable	=>	C_Enable,
											Z_Enable	=>	Z_Enable
										);




--MA/WB registers
MA_WB_1:	DATA_REGISTER_16	port map (Din => L5_1 , Dout => L6_1 , clk => clk, enable => '1', reset => reset);

L5_2_temp(4)	<=	L5_12;
L5_2_temp(3 downto 0)	<=	L5_2(3 downto 0);	
			
MA_WB_2:	DATA_REGISTER	generic map(5)
							port map (Din => L5_2_temp , Dout => L6_2 , clk => clk, enable => '1', reset => reset);
							
MA_WB_3:	DATA_REGISTER	generic map(16)
							port map (Din => L5_14 , Dout => L6_3 , clk => clk, enable => '1', reset => reset);
							
MA_WB_4:	DATA_REGISTER	generic map(16)
							port map (Din => L5_3 , Dout => L6_4 , clk => clk, enable => '1', reset => reset);
							
MA_WB_5:	DATA_REGISTER	generic map(16)
							port map (Din => L5_9 , Dout => L6_9 , clk => clk, enable => '1', reset => reset);
							
MA_WB_6:	DATA_REGISTER	generic map(3)
							port map (Din => L5_10 , Dout => L6_10 , clk => clk, enable => '1', reset => reset);
							
MA_WB_7:	DATA_REGISTER	generic map(16)
							port map (Din => L5_11 , Dout => L6_11 , clk => clk, enable => '1', reset => reset);

WB_Stage:	WRITE_BACK_STAGE port map(	
										clk	=>	clk,
										reset	=>	reset,
			
										L5_5	=>	L5_5,
										L5_16	=>	L5_16,
			
										L6_1	=>	L6_1,
										L6_2	=>	L6_2,
										L6_3	=>	L6_3,
										L6_4	=>	L6_4,
										L6_9	=>	L6_9,
										L6_10	=>	L6_10,
										L6_11	=>	L6_11,
										
										C_Enable	=>	C_Enable,
										Z_Enable	=>	Z_Enable,


										L6_5	=>	L6_5,
										L6_6	=>	L6_6,
										L6_7	=>	L6_7,
										L6_8	=>	L6_8
									  );

end Struct;
