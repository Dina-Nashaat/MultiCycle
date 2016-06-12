library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity Shifter26 is	 
	
Port(
inp: in STD_LOGIC_VECTOR(25 downto 0);
outp: out STD_LOGIC_VECTOR (27 downto 0)

);
end shifter26;

architecture Behavioral of Shifter26 is

begin
outp <= inp(25 downto 0) & "00";

end Behavioral;
