#/bin/sh
ghdl -a --ieee=synopsys -fexplicit BCD2Binary8.vhd
ghdl -a --ieee=synopsys -fexplicit BCD2Binary8_TB.vhd
ghdl -r --ieee=synopsys -fexplicit bcd2binary8_tb