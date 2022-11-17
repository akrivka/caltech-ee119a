----------------------------------------------------------------------------
-- 74LS194A 4-bit Bi-directional Universal Shift Register
-- (Dataflow architecture)
-- 
-- Modes:
--  (a) S0 = 1, S1 = 1: PARELLEL LOADING
--  (b) S0 = 1, S1 = 0: SHIFT LEFT
--  (c) S0 = 0, S1 = 1: SHIFT RIGHT
--  (d) S0 = 0, S1 = 0: HOLD
----------------------------------------------------------------------------

-- libries
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

--
-- IC74194 entity declaration
--
entity ic74194 is
    port (
        DI : in std_logic_vector(0 to 3); -- parllel input
        LSI : in std_logic; -- shift left serial input
        RSI : in std_logic; -- shift right serial input
        S : in std_logic_vector(1 downto 0); -- mode S = (S0, S1)
        CLR : in std_logic; -- clear signal (0 when active)
        CLK : in std_logic; -- clock
        DO : buffer std_logic_vector(0 to 3) -- parallel output
    );
end ic74194;

--
-- IC74194 dataflow architecture
--
architecture DataFlow of ic74194 is
begin
    process (CLK, CLR) begin
        if CLR = '0' then -- ASYNC CLEAR
            DO <= "0000";
        elsif rising_edge(CLK) then
            if S = "11" then -- PARALLEL LOADING
                DO <= DI;
            elsif S = "10" then -- SHIFT LEFT
                DO(2 downto 0) <= DO(3 downto 1);
                DO(3) <= LSI;
            elsif S = "01" then -- SHIFT RIGHT
                DO(3 downto 1) <= DO(2 downto 0);
                DO(0) <= RSI;
            elsif S = "00" then -- HOLD
            end if;
        end if;
    end process;
end DataFlow;