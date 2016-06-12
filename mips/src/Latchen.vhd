
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity latch is
generic(width: integer);
port(
clk, reset: in STD_LOGIC;
en: in STD_LOGIC;
d: in STD_LOGIC_VECTOR(width-1 downto 0);
q: out STD_LOGIC_VECTOR(width-1 downto 0));
end;
architecture async of latch is
begin
process(clk, reset) begin
	 q <= CONV_STD_LOGIC_VECTOR(0, width) when reset = '1'
	else d when (rising_edge(clk) and en ='1')  ;

end if;
end process;
end;