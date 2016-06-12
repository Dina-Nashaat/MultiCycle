library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use IEEE.STD_LOGIC_UNSIGNED.all;

entity TopFrame is
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
end;

Architecture Test of TopFrame is
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

component Memory
	port(
	A, WD: in STD_logic_vector (31 downto 0);
	clk, WE: in STD_logic;
	RD: out STD_logic_vector (31 downto 0)
	);
end component;
	
begin
	Controller1: Controller port map (clk, reset, Op, Funct, zero, MemWrite, IRWrite, RegWrite, PCEn,
										RegDst, MemtoReg, IorD, ALUSrcA, ALUSrcB, PCSrc, ALUControl);
	--Mem: Memory port map () -- Datapath needed
end;																								 