library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use IEEE.STD_LOGIC_UNSIGNED.all;

entity Controller_TB is
end;

architecture Test of Controller_TB is
component C_TopFrame
	port(
	--Input Signals
	clk, reset, zero: in STD_logic;
	Op, Funct: in STD_logic_vector (5 downto 0);
	--Register Enable Signals
	MemWrite, IRWrite, RegWrite, PCEn: buffer STD_logic;
	--MUX Select Signals
	RegDst, MemtoReg, IorD, ALUSrcA: buffer STD_logic;
	ALUSrcB: buffer STD_logic_vector (1 downto 0);
	PCSrc: buffer STD_logic_vector (1 downto 0);	 
	--ALUControl Output Signal
	ALUControl: buffer STD_logic_vector (2 downto 0)
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
	C_TB: C_TopFrame port map (clk, reset, zero, Op, Funct, MemWrite, IRWrite, RegWrite, PCEn, RegDst, MemtoReg, IorD, ALUSrcA,
								ALUSrcB, PCSrc, ALUControl);
	
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