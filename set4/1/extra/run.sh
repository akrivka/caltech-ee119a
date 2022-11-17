#/bin/sh
ghdl -a --ieee=synopsys -fexplicit BCD2BinaryGeneric.vhd
ghdl -a --ieee=synopsys -fexplicit BCD2BinaryGeneric_TB.vhd
ghdl -r --ieee=synopsys -fexplicit bcd2binaryGeneric_tb