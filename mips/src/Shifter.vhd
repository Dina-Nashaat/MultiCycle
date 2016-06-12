library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity shifter is
Port(
in32: in STD_LOGIC(31 downto 0);
out32: out STD_LOGIC (31 downto 0);

);
end shifter;

architecture Behavioral of shifter is

begin
out32 <= in32(29 downto 0) & "00";

end Behavioral;


