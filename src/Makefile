
SVFILES = alu.sv execute_stage.sv pipelined_multiplier.sv decode_stage.sv hazard_module.sv fetch_stage.sv memory_stage.sv ro_bus.sv icache_module.sv main_memory.sv processor_module.sv tb_proc.sv

.PHONY: $(SVFILES) modelsim

lint: $(SVFILES)

work:
	vlib work

$(SVFILES): work
	vlog -work work -sv $@

modelsim:
	$(MAKE) -C modelsim modelsim

modelsim_icache:
	$(MAKE) -C modelsim modelsim_icache

clean:
	rm -f *.svg *.png *.dot *.bak 
	rm -rf work
