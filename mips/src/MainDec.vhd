library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity MainDec is
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
end MainDec;

architecture RTL of MainDec is

Type stage_type is (fetch, decode, execute, memory, writeBack);
signal stage: stage_type;
signal controlSignals: std_logic_vector (10 downto 0);

process(reset,clk)
begin
	if(reset = '1') then
		stage <= fetch;
	elsif rising_edge(clk) then
		case stage is
			
			-- Fetch Stage
			when fetch =>
			stage <= decode;
			
			-- Decode Stage
			when decode=>
			case(op)
				when "" =>	
				when others =>
			end case
			
			-- Execute Stage
			when execute =>
			case(op)
				when "" =>
				when others =>
			end case
			
			-- Memory Stage
			when memory =>
			case(op)
			
			end case
			
			-- WriteBack Stage
			when writeBack =>
			case(op)
			end case;
			
			when others =>
		end case;
		
		end if;
end process;	
end MainDec;
