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
	ALUOp: out STD_logic_vector (1 downto 0)
	);				
end MainDec;

architecture RTL of MainDec is

Type stage_type is (fetch, decode, execute, memory, writeBack);
signal stage, nxt_stage: stage_type;
signal controlSignals: std_logic_vector (14 downto 0);

begin
process(reset,clk)
begin
	if(reset = '1') then
		nxt_stage <= fetch;	
		stage <= nxt_stage;
	elsif rising_edge(clk) then
		case nxt_stage is
			-- Fetch Stage
			when fetch => 
			controlSignals <= "101000000010000";
			stage <= nxt_stage;
			nxt_stage <= decode;
			
			-- Decode Stage
			when decode=>
			controlSignals <= "000000000110000";
			stage <= nxt_stage;
			nxt_stage <= execute;
			
			-- Execute Stage
			when execute =>
			case(op)is		  
				-- Execute Load Word
				when "100011" =>
				controlSignals <= "000010000100000";	 
				-- Execute R-Type
				when "000000" =>
				controlSignals <= "000010000000010";
				-- Execute BEQ
				when "000100" =>
				controlSignals <= "000011000000101";
				-- Addi Execute
				when "001000" =>
				controlSignals <= "000010000100000";
				when others =>
				controlSignals <= "000000000000000";
			end case;		
			stage <= nxt_stage;
			nxt_stage <= memory;
			
			-- Memory Stage
			when memory =>
			case(op) is
				--Load Word Memory
				when "100011" =>
				controlSignals <= "000000100000000";
				--Store Word Memory
				when "101011" => 
				controlSignals <= "010000100000000";	
				when others =>
				controlSignals <= "000000000000000";
			end case;
			stage <= nxt_stage;
			nxt_stage <= writeBack;
			
			-- WriteBack Stage
			when writeBack =>
			case(op) is		 
				--Load Word Write Back
				when "100011" => 
				controlSignals <= "000100010000000";
				
				--RType Write Back
				when "000000" =>
				controlSignals <= "000100001000000";
				
				--Addi Write Back
				when "001000"	=>
				controlSignals <= "000100000000000"; 
				when others =>
				controlSignals <= "000000000000000";
			end case;		  
			stage <= nxt_stage;
			nxt_stage <= fetch;
			
			when others =>
				controlSignals <= "000000000000000";
		end case;
		
		end if;
end process;	

PCWrite 	<= controlSignals(14);
MemWrite 	<= controlSignals(13);
IRWrite 	<= controlSignals(12);
RegWrite 	<= controlSignals(11);
ALUSrcA 	<= controlSignals(10);
Branch  	<= controlSignals(9);
IorD 		<= controlSignals(8); 
MemtoReg	<= controlSignals(7);
RegDst 		<= controlSignals(6);
ALUSrcB 	<= controlSignals(5 downto 4);
PCSrc 		<= controlSignals(3 downto 2);
ALUOp 		<= controlSignals(1 downto 0);
end;
