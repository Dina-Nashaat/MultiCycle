library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use IEEE.STD_LOGIC_UNSIGNED.all;

entity TestBench is
end;

architecture Test of TestBench is
component TopFrame
	port(
	--Input Signals
	clk, reset: in STD_logic
	);
end component; 

signal clk, reset, zero: STD_logic;
signal Op, Funct: STD_logic_vector (5 downto 0);
signal MemWrite, IRWrite, RegWrite, PCEn: STD_logic;
signal RegDst, MemtoReg, IorD, ALUSrcA: STD_logic;
signal ALUSrcB: STD_logic_vector (1 downto 0);
signal PCSrc: STD_logic_vector (1 downto 0);
signal ALUControl: STD_logic_vector (2 downto 0);

begin
	Top: TopFrame port map (clk, reset);
	
	process begin
		clk <= '1';
		wait for 5 ns;
		clk <= '0';
		wait for 5 ns;
	end process;
	
	process begin
		reset <= '1';
		wait for 22 ns;
		reset <= '0';
		wait;
	end process;
	
	--Dummy Processes
	process begin
		zero <= '1';
		wait for 100 ns;
		zero <= '0';
		wait for 100 ns;
	end process;
	
	process begin
		--Load Word Instruction
		Op <= "100011";
		wait;
	end process;
	
	process begin
		--Add Function
		Funct <= "100000";
		wait;
	end process;
	
end;	