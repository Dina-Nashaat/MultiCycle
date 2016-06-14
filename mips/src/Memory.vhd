library IEEE;
use IEEE.STD_LOGIC_1164.all; use STD.TEXTIO.all;
use IEEE.STD_LOGIC_UNSIGNED.all; use IEEE.STD_LOGIC_ARITH.all; 

entity Memory is
	port(
	A, WD: in STD_logic_vector (31 downto 0);
	clk, WE: in STD_logic;
	RD: out STD_logic_vector (31 downto 0)
	);
end;

architecture struct of Memory is
type RAM is array (63 downto 0) of STD_logic_vector (31 downto 0);
signal MemD: RAM;

begin
	process(clk) is
	file Mem_File: TEXT;
	variable L: LINE;
	variable C: Character;
	variable index, result: Integer;
	variable Mem: RAM;
	begin
		for i in 0 to 63 loop
			Mem(conv_integer(i)) := CONV_STD_LOGIC_VECTOR (0, 32);
		end loop;
		index := 0;
		FILE_OPEN (Mem_File, "Data.txt", READ_MODE);
		while not ENDFILE(Mem_File)loop
			READLINE(Mem_File, L);
			result := 0;
			for i in 1 to 8 loop
				READ (L, C);
				if '0' <= C and C <= '9' then
					result := result*16 + character'pos(C) - character'pos('0');
				elsif 'a' <= C and C <= 'f' then
					result := result*16 + character'pos(C) - character'pos('0') + 10;
				else report "Format error on line" & integer'image
					(index) severity error;
				end if;	
			end loop;
			Mem(index) := CONV_STD_LOGIC_VECTOR (result, 32);
			index := index + 1;
		end loop;
		FILE_CLOSE(Mem_File);
		MemD <= Mem;
		
		if clk'event and clk = '1' then
			if(WE = '1') then
				MemD(conv_integer(A(7 downto 2))) <= WD;
			end if;
		end if;
		
		RD <= MemD(conv_integer(A(7 downto 2)));
		
		end process;
end;
