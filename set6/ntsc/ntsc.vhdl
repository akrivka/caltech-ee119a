----------------------------------------------------------------------------
--- BLABLABLA
----------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity ntsc is
    port (
        clk : in std_logic;
        column_address : in std_logic_vector(0 to 9);
        row_address : in std_logic_vector(0 to 7);
        oddeven : in std_logic;
        videoblank : in std_logic;
        videosync : in std_logic;
    );
end ntsc;

architecture ntsc_behaviour of ntsc is
    signal clock : integer range 0 to 636;
    signal line : integer range 1 to 525;
begin
    -- a sort of a state machine
    process (clock, line)
    begin
        -- setting videoblank 
        if line <= 20 or (line >= 261 and line <= 283) or (line = 524 or line = 525) then
            videoblank <= 0;
        else
            videoblank <= 1;
        end if;

        -- setting videosync
        if line <= 3 or (line >= 6 and line <= 9) then
            if clock <= 23 or (clock >= 318 and clock <= 318 + 23) then
                videosync <= 0;
            else
                videosync <= 1;
            end if;
        end if;

    end process;

    -- basic clock and line counter 
    process (clk)
    begin
        if rising_edge(clk) then
            if clock = 635 then
                clock <= 1;
                if line = 525 then
                    line <= 1;
                else
                    line <= line + 1;
                end if;
            else
                clock <= clock + 1;
            end if;
        end if;
    end process;
end ntsc_behaviour;