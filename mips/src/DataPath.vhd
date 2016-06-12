library IEEE;
use IEEE.STD_LOGIC_1164.all; use STD.TEXTIO.all;
use IEEE.STD_LOGIC_UNSIGNED.all; use IEEE.STD_LOGIC_ARITH.all;

entity DataPath is
	port(
	clk: in STD_logic;
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
end;

architecture struct of DataPath is

end;