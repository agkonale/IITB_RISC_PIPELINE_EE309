library ieee;
use ieee.std_logic_1164.all;

package General_Components is

type MEM_16 is array (integer range <>) of std_logic_vector(15 downto 0);

component PRIORITY_ENCODER is  
	port(
			X :	in std_logic_vector (7 downto 0); 

		  	Y :	out std_logic_vector (2 downto 0)
		);    
end component; 
  
component SET_POS_ZERO is  
	port(
			X:		in std_logic_vector (7 downto 0); 
			POS:	in std_logic_vector (2 downto 0); 
			  
			Y:		out std_logic_vector (7 downto 0)
		);  
end component;

component SE6 is  
	port(
			X:	in std_logic_vector (5 downto 0); 
	
		  	Y:	out std_logic_vector (15 downto 0)
		 );  
end component;

component SE9 is  
	port(	
			X:	in std_logic_vector (8 downto 0); 
	
		  	Y:	out std_logic_vector (15 downto 0)
		 );   
end component;

component LH9 is  
	port(	
			X:	in std_logic_vector (8 downto 0); 
	
		  	Y:	out std_logic_vector (15 downto 0)
		 );  
end component;    

component MUX_16_8 is
 	port(
 			X0,X1,X2,X3,X4,X5,X6,X7: in std_logic_vector(15 downto 0); 
	 		Sel: in std_logic_vector(2 downto 0);  
	 		Y: out std_logic_vector(15 downto 0)
	 		 
	 	);
end component;


component DATA_REGISTER is
	generic (data_width:integer);
	port(
			clk:	in std_logic;
			reset: 	in std_logic;
			enable: in std_logic;			
			Din: 	in std_logic_vector(data_width-1 downto 0);
			
	      	Dout: 	out std_logic_vector(data_width-1 downto 0)
	      	
	     );
end component;

component DATA_REGISTER_16 is
	port(
			clk:	in std_logic;
			reset: 	in std_logic;
			enable: in std_logic;			
			Din: 	in std_logic_vector(15 downto 0);
			
	      	Dout: 	out std_logic_vector(15 downto 0)
	      	
	     );
end component;

component REGISTER_FILE is
	port(   clk:		in std_logic;
			reset: 		in std_logic;
			A1:			in std_logic_vector(2 downto 0);
			A2:			in std_logic_vector(2 downto 0);
			A3:			in std_logic_vector(2 downto 0); 
			D3: 		in std_logic_vector(15 downto 0); 
			reg_write: 	in std_logic; 
				 
			D1: 		out std_logic_vector(15 downto 0); 
			D2: 		out std_logic_vector(15 downto 0)
			
		);	 
end component;


component PROGRAM_MEMORY is
	port(		
			Address:	in std_logic_vector(6 downto 0);
			
			Dout: 		out std_logic_vector(15 downto 0)
	     );      
end component;


component DATA_MEMORY is
	port(	clk:		in std_logic;
			reset:		in std_logic;
			mem_write:	in std_logic;
			mem_read:	in std_logic;			
			Address:	in std_logic_vector(6 downto 0);
			Din: 		in std_logic_vector(15 downto 0);
			
			Dout: 		out std_logic_vector(15 downto 0)
	     );      
end component;


component INSTRUCTION_FETCH_STAGE is
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
end component;


component INSTRUCTION_DECODE_STAGE is
	port(
			L2_1: in std_logic_vector(15 downto 0);
			L2_2: in std_logic_vector(15 downto 0);
			
			L3_1: in std_logic_vector(15 downto 0);
			

			L2_4: out std_logic_vector(16 downto 0);
			L2_5: out std_logic_vector(15 downto 0);	
			L2_8: out std_logic_vector(15 downto 0);	
			L2_9: out std_logic_vector(15 downto 0);
			L2_10: out std_logic_vector(2 downto 0);
			L2_11: out std_logic_vector(7 downto 0)
					
	     );      
end component;


component REGISTER_READ_STAGE is
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
end component;


component EXECUTION_STAGE is
	port(	L4_1: in std_logic_vector(15 downto 0);
			L4_2: in std_logic_vector(15 downto 0);
			L4_3: in std_logic_vector(15 downto 0);			
			L4_4: in std_logic_vector(15 downto 0);
			L4_5: in std_logic_vector(15 downto 0);
			
			L5_8: in std_logic_vector(15 downto 0);		
			
			
			L4_11: out std_logic;
			L4_12: out std_logic_vector(15 downto 0);
			L4_13: out std_logic_vector(0 downto 0);
			L4_14: out std_logic_vector(0 downto 0)
	     );      
end component;



component MEMORY_ACCESS_STAGE is
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
end component;


component WRITE_BACK_STAGE is
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
end component;



component TOP_LEVEL is
	 port  (

	 		clk:		in std_logic;
	 		reset:		in std_logic;
	 		
	 		RESULT: out std_logic_vector(15 downto 0)
				 		
	 	   ); 
end component;


end General_Components;



