library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity shifter is	 
	generic (Width : Integer := 32);
Port(
inp: in STD_LOGIC_VECTOR(Width-1 downto 0);
outp: out STD_LOGIC_VECTOR (Width-1 downto 0)

);
end shifter;

architecture Behavioral of shifter is

begin
outp <= inp(Width-3 downto 0) & "00";

end Behavioral;
