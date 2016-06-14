library IEEE;
use IEEE.STD_LOGIC_1164.all; use STD.TEXTIO.all;
use IEEE.STD_LOGIC_UNSIGNED.all; use IEEE.STD_LOGIC_ARITH.all;

entity Processor is
	port(
	clk, reset: in STD_logic;
	-- Input form Memory
	RD: in STD_logic_vector (31 downto 0);
	-- Output to Memory
	MemWrite: buffer STD_logic;
	Adr, WD: out STD_logic_vector (31 downto 0)
	);										   
end;

architecture Struct of Processor is
component Controller
	port(
	--clock and reset signals
	clk, reset: in STD_logic;
	--Input signals
	op, funct: in STD_logic_vector (5 downto 0);
	zero: in STD_logic;
	--Register Enable Signals
	MemWrite, IRWrite, RegWrite, PCEn: out STD_logic;
	--MUX Select Signals
	RegDst, MemtoReg, IorD, ALUSrcA: out STD_logic;
	ALUSrcB: out STD_logic_vector (1 downto 0);
	PCSrc: out STD_logic_vector (1 downto 0);	 
	--ALUControl Output Signal
	ALUControl: out STD_logic_vector (2 downto 0)
	);
end component;

component DataPath
	port(
	clk, reset: in STD_logic;
	-- Inputs from Controller
	PCEn, IorD, IRWrite: in STD_logic;
	RegDst, MemtoReg: in STD_logic;
	RegWrite, ALUSrcA: in STD_logic;
	ALUSrcB, PCSrc: in STD_logic_vector (1 downto 0);
	ALUControl: in STD_logic_vector (2 downto 0);
	-- Inputs from Memory
	RD: in STD_logic_vector (31 downto 0);
	-- Outputs to Controller
	zero: out STD_logic;
	Op, Funct: out STD_logic_vector (5 downto 0);
	-- Outputs to Memory
	Adr, WD: out STD_logic_vector (31 downto 0) 
	);	
end component;

signal zero: STD_logic;
signal Op, Funct: STD_logic_vector (5 downto 0);
--Register Enable Signals
signal IRWrite, RegWrite, PCEn: STD_logic;
--MUX Select Signals
signal RegDst, MemtoReg, IorD, ALUSrcA: STD_logic;
signal ALUSrcB: STD_logic_vector (1 downto 0);
signal PCSrc: STD_logic_vector (1 downto 0);	 
--ALUControl Output Signal
signal ALUControl: STD_logic_vector (2 downto 0);

begin
	Controller1: Controller port map (clk, reset, Op, Funct, zero, MemWrite, IRWrite, RegWrite, PCEn,
										RegDst, MemtoReg, IorD, ALUSrcA, ALUSrcB, PCSrc, ALUControl);
	
	Dp: DataPath port map (clk, reset, PCEn, IorD, IRWrite, RegDst, MemtoReg, RegWrite, ALUSrcA, ALUSrcB, PCSrc, ALUControl,
								RD, zero, Op, Funct, Adr, WD);
end;

