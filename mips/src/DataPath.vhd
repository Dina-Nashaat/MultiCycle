library IEEE;
use IEEE.STD_LOGIC_1164.all; use STD.TEXTIO.all;
use IEEE.STD_LOGIC_UNSIGNED.all; use IEEE.STD_LOGIC_ARITH.all;

entity DataPath is
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

component Shifter26 
	port(
	inp: in STD_LOGIC_VECTOR(25 downto 0);
	outp: out STD_LOGIC_VECTOR (27 downto 0)
	);
end component;

component Shifter32 
	port(
	inp: in STD_LOGIC_VECTOR(31 downto 0);
	outp: out STD_LOGIC_VECTOR (31 downto 0)
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

signal ImmExt, ImmExtSl2: std_logic_vector (31 downto 0);			  

signal SrcA, SrcB, ALUResult, ALUOut : std_logic_vector  (31 downto 0);


signal writeReg: std_logic_vector (4 downto 0);
signal regInput: std_logic_vector (31 downto 0);   
signal RD1, RD2: std_logic_vector (31 downto 0); --Register Output before latch
signal rdA, rdB: std_logic_vector (31 downto 0); --Register Output after latch

signal PCJump, PCNext, PC: std_logic_vector (31 downto 0);
signal jumpShift: std_logic_vector (27 downto 0);

begin
		
	--PC Increment and Select Logic
	PCLatch		: Latch generic map (32) port map (clk, reset, PCEn, PCNext, PC);
	PCMux  		: Mux2 generic map (32) port map (IorD, PC, ALUOut, Adr);
	signEx      : Signext port map (Instr(15 downto 0), ImmExt);
	shft32      : Shifter32 port map (ImmExt, ImmExtSl2);				   
	shft26      : Shifter26 port map (Instr(25 downto 0), jumpShift);
	PCJump      <= PC(31 downto 28) & jumpShift;
	
	--Memory Select Logic
	InstrLatch	: Latch generic map (32) port map (clk, reset, IRWrite, RD, instr);
	DataLatch 	: Latch generic map (32) port map  (clk, reset, '1', RD, data);
	
	--Register File Logic 
	rF          : RegFile port map (clk, RegWrite,
									instr(25 downto 21), instr(20 downto 16),
									writeReg,regInput,
									RD1, RD2);
	writeRegMux : Mux2 generic map (5) port map (RegDst, instr(20 downto 16),instr(15 downto 11), writeReg);
	regInputMux : Mux2 generic map (32) port map (MemtoReg, ALUOut, data, regInput);
	srcALatch   : Latch generic map (32) port map (clk, reset, '1', RD1, rdA);
	srcBLatch   : Latch generic map (32) port map (clk, reset, '1', RD2, rdB);
	
	
	--ALU Logic
	srcAMux    : Mux2 generic map(32) port map (ALUSrcA, PC, rdA, SrcA);
	srcBMux    : Mux4 generic map(32) port map (ALUSrcB, rdB, X"00000004",ImmExt, ImmExtSl2, SrcB);
	ALUComp    : ALU port map (SrcA, SrcB, ALUControl,zero, ALUResult);
	ALUOutMux  : Mux4 generic map (32) port map (PCSrc, ALUResult, ALUOut,PCJump, x"00000000",PCNext);
end;