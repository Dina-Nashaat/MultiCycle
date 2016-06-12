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
component RegFile 
	port( 
	clk, we3: in std_logic;
	ra1, ra2 : in std_logic_vector (4 downto 0); -- Read Address Port
	wa3 : in std_logic_vector(4 downto 0);	   -- Write Address Port
	wd3 : in std_logic_vector (31 downto 0);
	rd1, rd2 : out std_logic_vector(31 downto 0)
	);
end component;

component ALU 
	Port(
	A: in STD_LOGIC_VECTOR(31 downto 0);	--input A	  
	B: in STD_LOGIC_VECTOR(31 downto 0);  	--input B
	C: in STD_LOGIC_VECTOR(2 downto 0);	 --control 
	Z: out STD_LOGIC :='0';			  --zero
	AluOut: out STD_LOGIC_VECTOR (31 downto 0)
	);
end component;

component Signext 
	port(
	a: in STD_LOGIC_VECTOR (15 downto 0);
	output: out STD_LOGIC_VECTOR(31 downto 0)
	);
end component;

component Shifter 
	generic (Width : Integer := 32);
	port(
	inp: in STD_LOGIC_VECTOR(Width-1 downto 0);
	outp: out STD_LOGIC_VECTOR (Width-1 downto 0)
	);
end component;

component Latch	
	generic(width: integer);
	port(
	clk, reset: in STD_LOGIC;
	en: in STD_LOGIC;
	d: in STD_LOGIC_VECTOR(width-1 downto 0);
	q: out STD_LOGIC_VECTOR(width-1 downto 0));
end component;

component Mux2
	generic (width: integer);
	port(
	selector : in std_logic;
	in0, in1 : in std_logic_vector(width-1 downto 0);
	output   : out STD_LOGIC_VECTOR(width-1 downto 0)
	) ;
end component;

component Mux4	
	generic(width: integer);
	port(				  
	selector: in STD_LOGIC_VECTOR (1 downto 0);
	in0, in1, in2, in3: in STD_LOGIC_VECTOR (width-1 downto 0);
	output: out STD_LOGIC_VECTOR (width-1 downto 0)
	);
end component;


signal instr: std_logic_vector (31 downto 0);
signal data : std_logic_vector (31 downto 0);

signal ImmExt: std_logic_vector (31 downto 0);			  

signal SrcA, SrcB, ALUResult, ALUOut : std_logic_vector  (31 downto 0);

signal PCJump, PCNext, PC: std_logic_vector (31 downto 0);

begin
	
end;