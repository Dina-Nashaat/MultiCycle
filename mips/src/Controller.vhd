library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Controller is -- MultiCycle Controller
	port(
	--clock and reset signals
	clk, reset: in STD_logic;
	--Input signals
	op, funct: in STD_logic_vector (5 downto 0);
	zero: in STD_logic;
	--Register Enable Signals
	Branch, MemWrite, IRWrite, RegWrite, PCEn: out STd_logic;
	--MUX Select Signals
	RegDst, MemtoReg, IorD, ALUSrcA: out STD_logic;
	ALUSrcB: out STD_logic_vector (1 downto 0);
	PCSrc: out STD_logic_vector (1 downto 0);	 
	--ALUControl Output Signal
	ALUControl: out STD_logic_vector (2 downto 0)
	);
end;

architecture struct of Controller is
signal ALUOp: STD_logic_vector (1 downto 0);
signal PCWrite, Branch: STD_logic;

component ALUDec 
	port(
	funct: in STD_logic_vector (5 downto 0);
	ALUOp: in STD_logic_vector (1 downto 0);
	ALUControl: out STD_logic_vector (2 downto 0)
	);	 
end component;									

component MainDec	
	port(
	--Clock and Reset Signals
	clk, reset: in STD_logic;  				
	--Input OPCODE
	op: in STD_Logic_vector (5 downto 0);	
	--Register Enable Signals
	Branch, MemWrite, IRWrite, RegWrite, PCWrite: out STD_logic;
	--MUX Select Signals
	RegDst, MemtoReg, IorD,ALUSrcA: out STD_Logic;
	ALUSrcB: out STD_logic_vector (1 downto 0);
	PCSrc: out STD_logic_vector (1 downto 0);
	--ALUDEC Output
	ALUOp: out STD_logic_vector (1 downto 0);
	);					   
end component;

begin
	PCEn <= (Branch AND zero) OR PCWrite;
	
	md: MainDec port map (clk, reset,op,
						Branch, MemWrite, IRWrite, RegWrite, PCWrite,
						RegDst, MemtoReg, IorD, ALUSrcA, ALUSrcB, PCSrc,
						ALUOp);
	ad: ALUDec port map (funct, ALUOp, ALUControl);
end;