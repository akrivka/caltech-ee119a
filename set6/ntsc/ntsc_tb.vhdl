entity ntsc_tb is
end ntsc_tb;

architecture tb_architecture of ntsc_tb is
    component ntsc
        port (
            clk : in std_logic;
        );
    end component;
begin
    process
    begin
        clk <= '1';
        wait for 10 ns;
        clk <= '0';
        wait for 90 ns;
    end process;
end
end tb_architecture;

configuration testbench_for_ntsc of ntsc_tb is
    for tb_architecture
        for UUT : ntsc
            use entity work.ntsc(ntsc_behaviour)
        end for;
    end for;
end testbench_for_ntsc;