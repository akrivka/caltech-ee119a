#/bin/sh
ghdl -a --ieee=synopsys -fexplicit BCD2Binary8.vhd
ghdl -a --ieee=synopsys -fexplicit BCD2Binary8_TB.vhd
ghdl -r --wave=bcd2binary8_tb.ghw --ieee=synopsys -fexplicit bcd2binary8_tb