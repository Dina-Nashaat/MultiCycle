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
signal stage: stage_type;
signal controlSignals: std_logic_vector (14 downto 0);

begin
process(reset,clk)
begin
	if(reset = '1') then
		stage <= fetch;
	elsif rising_edge(clk) then
		case stage is
			-- Fetch Stage
			when fetch => 
			controlSignals <= "001100000100000";
			stage <= decode;
			
			-- Decode Stage
			when decode=>
			controlSignals <= "000000001100000";
			stage <= execute;
			
			-- Execute Stage
			when execute =>
			case(op)is		  
				-- Execute Load Word
				when "100011" =>
				controlSignals <= "000000011000000";	 
				-- Execute R-Type
				when "000000" =>
				controlSignals <= "000000010000100";
				-- Execute BEQ
				when "000100" =>
				controlSignals <= "100000010001010";
				-- Addi Execute
				when "001000" =>
				controlSignals <= "000000011000000";
				when others =>
				controlSignals <= "000000000000000";
			end case;
			stage <= memory;
			
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
			stage <= writeBack;
			
			-- WriteBack Stage
			when writeBack =>
			case(op) is		 
				--Load Word Write Back
				when "100011" => 
				controlSignals <= "000101000000000";
				
				--RType Write Back
				when "000000" =>
				controlSignals <= "000110000000000";
				
				--Addi Write Back
				when "001000"	=>
				controlSignals <= "000100000000000"; 
				when others =>
				controlSignals <= "000000000000000";
			end case;		  
			stage <= fetch;
			when others =>
				controlSignals <= "000000000000000";
		end case;
		
		end if;
end process;	

end;
