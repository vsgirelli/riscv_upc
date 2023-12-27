
SVFILES = alu.v execute_stage.v pipelined_multiplier.v decode_stage.v fetch_stage.v memory_stage.v processor.v write_back_stage.v tb_proc.v

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
