----------------------------------------------------------------------------
-- 8-bit Bi-directional Universal Shift Register
-- using 2x 74LS194A 4-bit shift registers
-- (structural architecture)
-- 
-- The left 4-bit shift register corresponds to the 
-- input and output values indexed 7 to 4, and its
-- shift left serial input is the leftmost bit of the 
-- right 4-bit register (Q(3)) and its shift right serial
-- input is the same as the whole circuits. Similarly, 
-- the right 4-bit shift register corresponds to values
-- indexed 3 to 0 and its shift left register is 
-- the same as the whole circuit's, and its shift right
-- register is the rightmost bit of the left 4-bit 
-- register (Q(4)).
-- 
-- Modes (same as for 74LS194A):
--  (a) S0 = 1, S1 = 1: PARELLEL LOADING
--  (b) S0 = 1, S1 = 0: SHIFT LEFT
--  (c) S0 = 0, S1 = 1: SHIFT RIGHT
--  (d) S0 = 0, S1 = 0: HOLD

----------------------------------------------------------------------------
-- libraries
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

--
-- UniversalSR8 entity declaration
--
entity UniversalSR8 is
    port (
        D : in std_logic_vector(7 downto 0); -- parallel input
        LSer : in std_logic; -- shift left serial input
        RSer : in std_logic; -- shift right serial input
        Mode : in std_logic_vector(1 downto 0); -- Mode = (S0, S1)
        CLR : in std_logic; -- clear signal (0 when active)
        CLK : in std_logic; -- clock
        Q : buffer std_logic_vector(7 downto 0) -- parallel output
    );
end UniversalSR8;

--
-- UniversalSR8 structural architecture
--
architecture Structural of UniversalSR8 is
    -- IC74194 component declaration
    component ic74194
        port (
            DI : in std_logic_vector(0 to 3); -- parllel input
            LSI : in std_logic; -- shift left serial input
            RSI : in std_logic; -- shift right serial input
            S : in std_logic_vector(1 downto 0); -- mode S = (S0, S1)
            CLR : in std_logic; -- clear signal (0 when active)
            CLK : in std_logic; -- clock
            DO : buffer std_logic_vector(0 to 3) -- parallel output
        );
    end component;
begin
    -- left 4-bit register
    ul : ic74194 port map(D(7 downto 4), Q(3), RSer, Mode, CLR, CLK, Q(7 downto 4));
    -- right 4-bit register
    ur : ic74194 port map(D(3 downto 0), LSer, Q(4), Mode, CLR, CLK, Q(3 downto 0));
end Structural;