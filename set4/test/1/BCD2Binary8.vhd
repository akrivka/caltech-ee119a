----------------------------------------------------------------------------
-- 8-bit/2-digit BCD value to 8-bit binary value conversion
--
-- This is a simple dataflow implementation of an 8-bit/2-digit BCD 
-- (binary coded digit) value to 8-bit binary value conversion, in the form
-- abcdefgh => abcd*10 + efgh.
-- 
-- It uses an arithmetic trick to avoid multiplication: 10 = 8 + 2, 
-- in other words, we can achieve multiplication by 10 by first multiplying by 8
-- (left shift by 3) add adding with multiplying by 2 (left shift by 2).
----------------------------------------------------------------------------

-- libraries
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

--
-- BCD2Binary8 entity declaration
--
entity BCD2Binary8 is
    port (
        BCD : in std_logic_vector(7 downto 0); -- BCD input 
        B : out std_logic_vector(7 downto 0) -- binary output
    );
end BCD2Binary8;

--
-- BCD2Binary8 dataflow architecture
--
architecture DataFlow of BCD2Binary8 is
    signal digit1 : unsigned(3 downto 0);
    signal digit2 : unsigned(3 downto 0);

begin
    -- get the first and second digit
    digit1 <= unsigned(BCD(7 downto 4));
    digit2 <= unsigned(BCD(3 downto 0));

    -- B = digit1 * 10 + digit2
    --   = digit1 * (8 + 2) + digit2
    --   = digit1 * 8 + digit1 * 2 + digit2
    --   = (digit1 << 3) + (digit1 << 1) + digit2
    B <= std_logic_vector(("0" & digit1 & "000") + ("000" & digit1 & "0") + ("0000" & digit2));
end DataFlow;