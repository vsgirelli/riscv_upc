
SVFILES+= processor_model.sv

VLOG_FILES=$(patsubst %.sv, %_vlog, $(SVFILES))

all: work

work: $(VLOG_FILES)

%_vlog: ../%.sv
	vlog -work work -suppress 7061 -sv $^

modelsim: work
	vsim work.tb_proc -do tb_proc_env.do

clean:
	rm -rf work wlft*

.PHONY: work

