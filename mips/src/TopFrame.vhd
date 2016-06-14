library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use IEEE.STD_LOGIC_UNSIGNED.all;

entity TopFrame is
	port(
	--Input Signals
	clk, reset: in STD_logic;
	MemWrite: buffer STD_logic;
	Adr, WD: buffer STD_logic_vector(31 downto 0)
	);
end;

Architecture Test of TopFrame is
component Processor
	port(
	clk, reset: in STD_logic;
	-- Input form Memory
	RD: in STD_logic_vector (31 downto 0);
	-- Output to Memory
	MemWrite: buffer STD_logic;
	Adr, WD: out STD_logic_vector (31 downto 0)
	);
end component;

component Memory
	port(
	A, WD: in STD_logic_vector (31 downto 0);
	clk, WE: in STD_logic;
	RD: out STD_logic_vector (31 downto 0)
	);
end component;

-- Memory Signals
signal RD: STD_logic_vector (31 downto 0);

begin
	Mips: Processor port map (clk, reset, RD, MemWrite, Adr, WD);
	
	Mem: Memory port map (Adr, WD, clk, MemWrite, RD);
end;																								 