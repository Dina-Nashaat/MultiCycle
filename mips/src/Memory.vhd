library IEEE;
use IEEE.STD_LOGIC_1164.all; use STD.TEXTIO.all;
use IEEE.STD_LOGIC_UNSIGNED.all; 

entity Memory is
	port(
	A, WD: in STD_logic_vector (31 downto 0);
	clk, WE: in STD_logic;
	RD: out STD_logic_vector (31 downto 0)
	);
end;

architecture behave of Memory is
type RAM is array (63 downto 0) of STD_logic_vector (31 downto 0);
signal Mem: RAM;

begin
	process(clk) begin
		if clk'event and clk = '1' then
			if(WE = '1') then
				Mem(conv_integer(A(7 downto 2))) <= WD;
			end if;
		end if;
		
		RD <= Mem(conv_integer(A(7 downto 2)));
		
		end process;
end;
