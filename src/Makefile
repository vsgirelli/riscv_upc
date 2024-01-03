
SVFILES = alu.sv execute_stage.sv pipelined_multiplier.sv decode_stage.sv fetch_stage.sv memory_stage.sv processor_model.sv write_back_stage.sv tb_proc.sv

.PHONY: $(SVFILES) modelsim

lint: $(SVFILES)

work:
	vlib work

$(SVFILES): work
	vlog -work work -sv $@

modelsim:
	$(MAKE) -C modelsim modelsim

clean:
	rm -f *.svg *.png *.dot *.bak 
	rm -rf work
