
SVFILES=constants_pkg.sv structure_pkg.sv alu.sv decode_stage.sv execute_stage.sv fetch_stage.sv icache_module.sv memory_stage.sv pipelined_multiplier.sv register_file.sv hazard_module.sv processor_model.sv ro_bus.sv rw_bus.sv memory_controller.sv main_memory.sv dcache_module.sv icache_module.sv tb_proc.sv tb_icache.sv


VLOG_FILES=$(patsubst %.sv, %_vlog, $(SVFILES))

all: work

work: $(VLOG_FILES)

%_vlog: ../%.sv
	vlog -work work -sv $^

modelsim: work
	vsim work.tb_proc -do initial.do

modelsim_icache: work
	vsim work.tb_icache -do tb_icache_env.do

clean:
	rm -rf work wlft*

.PHONY: work

