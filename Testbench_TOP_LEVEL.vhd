library ieee;
use ieee.std_logic_1164.all;

library work;
use work.General_Components.all;

entity Testbench_TOP_LEVEL is
end entity;

architecture Behave of Testbench_TOP_LEVEL is

signal clk, reset: std_logic;
signal RESULT:	std_logic_vector(15 downto 0);

begin

process
begin
    clk<='1';			-- clock signal
    wait for 500 ns;
    clk<='0';
    wait for 500 ns;
end process;


process	
begin
	reset<='0';
	wait for 1500 ns;
	reset<='1';
	wait;
end process;
	
dut:TOP_LEVEL
port map(	
		clk,
		reset,
		RESULT
 	   	); 
	 	   		
end Behave;
