
SVFILES=constants_pkg.sv instruction_pkg.sv alu.sv decode_stage.sv execute_stage.sv fetch_stage.sv icache_module.sv memory_stage.sv pipelined_multiplier.sv register_file.sv write_back_stage.sv processor_model.sv tb_proc.sv 


VLOG_FILES=$(patsubst %.sv, %_vlog, $(SVFILES))

all: work

work: $(VLOG_FILES)

%_vlog: ../%.sv
	vlog -work work -sv $^

modelsim: work
	vsim work.tb_proc -do tb_proc_env.do

clean:
	rm -rf work wlft*

.PHONY: work

