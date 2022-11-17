#/bin/sh
ghdl -a --std=08 --ieee=synopsys -fexplicit ic74194.vhd
ghdl -a --std=08 --ieee=synopsys -fexplicit ic74194_TB.vhd
ghdl -r --std=08 --ieee=synopsys -fexplicit ic74194_tb