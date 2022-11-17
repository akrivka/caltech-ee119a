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
-- Helper entity declaration
--
entity Helper is
    generic (
        length : integer
    );

    port (
        A : in unsigned((length - 5) downto 0);
        B : in unsigned(3 downto 0);
        O : out unsigned((length - 1) downto 0)
    );
end Helper;

--
-- Helper dataflow architecture
--
architecture DataFlow of Helper is
begin
    O <= ("0" & A & "000") + ("000" & A & "0") + ("0000" & B);
end DataFlow;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

--
-- BCD2Binary8 entity declaration
--
entity BCD2Binary is
    generic (
        nbits : integer
    );

    port (
        BCD : in std_logic_vector((nbits - 1) downto 0); -- BCD input 
        B : out std_logic_vector((nbits - 1) downto 0) -- binary output
    );
end BCD2Binary;

--
-- BCD2Binary8 dataflow architecture
--
architecture DataFlow of BCD2Binary is
    component Helper
        generic (
            length : integer
        );
        port (
            A : in unsigned((length - 5) downto 0);
            B : in unsigned(3 downto 0);
            O : out unsigned((length - 1) downto 0)
        );
    end component;

    constant ncomps : integer := nbits / 4 - 1;
    type t_prefix is array(0 to ncomps) of unsigned((nbits - 1) downto 0);
    signal prefix : t_prefix;

begin
    -- 8-bit adders
    prefix(ncomps) <= resize(unsigned(BCD((nbits - 1) downto (nbits - 4))), nbits);

    Adders : for i in prefix'range generate
        asdf : if i < ncomps generate
            u : Helper generic map(nbits)
            port map(
                A => prefix(i+1),
                B => unsigned(BCD(nbits - 1 - (ncomps - i) * 4 downto nbits - 4 - (ncomps - i) * 4)),
                O => prefix(i)
            );
        end generate;
    end generate;
end DataFlow;