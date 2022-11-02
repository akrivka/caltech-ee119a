-- TODO
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity UniversalSR8 is
    port (
        D : in std_logic_vector(7 downto 0);
        LSer : in std_logic;
        RSer : in std_logic;
        Mode : in std_logic_vector(1 downto 0);
        CLR : in std_logic;
        CLK : in std_logic;
        Q : buffer std_logic_vector(7 downto 0)
    );
end UniversalSR8;

architecture Structural of UniversalSR8 is
    component ic74194
        port (
            DI : in std_logic_vector(0 to 3);
            LSI : in std_logic;
            RSI : in std_logic;
            S : in std_logic_vector(1 downto 0);
            CLR : in std_logic;
            CLK : in std_logic;
            DO : buffer std_logic_vector(0 to 3)
        );
    end component;
begin
    ul : ic74194 port map(D(7 downto 4), Q(3), RSer, Mode, CLR, CLK, Q(7 downto 4));
    ur : ic74194 port map(D(3 downto 0), LSer, Q(4), Mode, CLR, CLK, Q(3 downto 0));
end Structural;