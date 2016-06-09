library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Controller is -- MultiCycle Controller
	port(clk: in STD_logic;
	op, funct: in STD_logic_vector (5 downto 0);
	zero: in STD_logic;
	IorD, MemWrite, IRWrite, RegWrite: out STd_logic;
	PCSrc: out STD_logic_vector (1 downto 0);
	ALUControl: out STD_logic_vector (2 downto 0);
	ALUSrcB: out STD_logic_vector (1 downto 0);
	ALUSrcA: out STD_logic;
	RegDst, MemtoReg: out STD_logic;
	PCEn: out STD_logic
	);
end;

architecture struct of Controller is
signal ALUOp: STD_logic_vector (1 downto 0);
signal PCWrite, Branch: STD_logic;