-- TODO

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
entity ic74194 is
    port (
        DI : in std_logic_vector(0 to 3);
        LSI : in std_logic;
        RSI : in std_logic;
        S : in std_logic_vector(1 downto 0);
        CLR : in std_logic;
        CLK : in std_logic;
        DO : buffer std_logic_vector(0 to 3)
    );
end ic74194;

architecture DataFlow of ic74194 is

begin
    process (CLK, CLR) begin
        if CLR = '0' then
            DO <= "0000";
        elsif rising_edge(CLK) then
            if S = "11" then -- PARALLEL LOADING
                DO <= DI;
            elsif S = "10" then -- SHIFT LEFT
                DO(0) <= DO(1);
                DO(1) <= DO(2);
                DO(2) <= DO(3);
                DO(3) <= LSI;
            elsif S = "01" then -- SHIFT RIGHT
                DO(3) <= DO(2);
                DO(2) <= DO(1);
                DO(1) <= DO(0);
                DO(0) <= RSI;
            elsif S = "00" then -- HOLD
            end if;
        end if;
    end process;
end DataFlow;