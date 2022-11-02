-- intro todo

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity BCD2Binary8 is
    port (
        BCD : in std_logic_vector(7 downto 0);
        B : out std_logic_vector(7 downto 0)
    );
end BCD2Binary8;

architecture DataFlow of BCD2Binary8 is
    signal digit1 : unsigned(7 downto 0);
    signal digit2 : unsigned(7 downto 0);

begin
    digit1 <= resize(unsigned(BCD(7 downto 4)), 8);
    digit2 <= resize(unsigned(BCD(3 downto 0)), 8);

    B <= std_logic_vector((digit1 sll 3) + (digit1 sll 1) + digit2);
end DataFlow;