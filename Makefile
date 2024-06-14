MODULES += sub/SystemVerilog/rtl/decoder.sv
MODULES += sub/SystemVerilog/rtl/mux.sv
MODULES += sub/SystemVerilog/rtl/demux.sv
MODULES += sub/SystemVerilog/rtl/mem.sv
MODULES += sub/SystemVerilog/rtl/gray_to_bin.sv
MODULES += sub/SystemVerilog/rtl/bin_to_gray.sv
MODULES += sub/SystemVerilog/rtl/register.sv
MODULES += sub/SystemVerilog/rtl/register_dual_flop.sv
MODULES += sub/SystemVerilog/rtl/cdc_fifo.sv
MODULES += tb/cdc_fifo_tb.sv
#MODULES +=
#MODULES +=

TOP = cdc_fifo_tb

vivado: 
	xvlog -sv ${MODULES}  
	xelab ${TOP} -s top   
	xsim top -runall

clean: 
	rm -rf *.log *.pb *.jou xsim.dir

.PHONY: 
	vivado clean


