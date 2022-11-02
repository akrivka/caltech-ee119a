#/bin/sh
ghdl -a --std=08 --ieee=synopsys -fexplicit ic74194.vhd
ghdl -a --std=08 --ieee=synopsys -fexplicit UniversalSR8.vhd
ghdl -a --std=08 --ieee=synopsys -fexplicit UniversalSR8_TB.vhd
ghdl -r --std=08 --ieee=synopsys -fexplicit universalsr8_tb