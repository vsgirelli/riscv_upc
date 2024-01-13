onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_proc/proc0/clk
add wave -noupdate /tb_proc/proc0/rst
add wave -noupdate -divider {Decoupling Registers}
add wave -noupdate -radix hexadecimal /tb_proc/proc0/inst_dec_next
add wave -noupdate -radix hexadecimal -childformat {{/tb_proc/proc0/inst_exe_next.valid -radix hexadecimal} {/tb_proc/proc0/inst_exe_next.src_data_1 -radix hexadecimal} {/tb_proc/proc0/inst_exe_next.src_data_2 -radix hexadecimal} {/tb_proc/proc0/inst_exe_next.dst_reg -radix hexadecimal} {/tb_proc/proc0/inst_exe_next.dst_reg_data -radix hexadecimal} {/tb_proc/proc0/inst_exe_next.reg_write_enable -radix hexadecimal} {/tb_proc/proc0/inst_exe_next.reg_data_ready -radix hexadecimal} {/tb_proc/proc0/inst_exe_next.func3 -radix hexadecimal} {/tb_proc/proc0/inst_exe_next.func7 -radix hexadecimal} {/tb_proc/proc0/inst_exe_next.is_load -radix hexadecimal} {/tb_proc/proc0/inst_exe_next.is_store -radix hexadecimal} {/tb_proc/proc0/inst_exe_next.is_reg_reg -radix hexadecimal} {/tb_proc/proc0/inst_exe_next.is_mul -radix hexadecimal} {/tb_proc/proc0/inst_exe_next.immediate -radix hexadecimal}} -expand -subitemconfig {/tb_proc/proc0/inst_exe_next.valid {-radix hexadecimal} /tb_proc/proc0/inst_exe_next.src_data_1 {-radix hexadecimal} /tb_proc/proc0/inst_exe_next.src_data_2 {-radix hexadecimal} /tb_proc/proc0/inst_exe_next.dst_reg {-radix hexadecimal} /tb_proc/proc0/inst_exe_next.dst_reg_data {-radix hexadecimal} /tb_proc/proc0/inst_exe_next.reg_write_enable {-radix hexadecimal} /tb_proc/proc0/inst_exe_next.reg_data_ready {-radix hexadecimal} /tb_proc/proc0/inst_exe_next.func3 {-radix hexadecimal} /tb_proc/proc0/inst_exe_next.func7 {-radix hexadecimal} /tb_proc/proc0/inst_exe_next.is_load {-radix hexadecimal} /tb_proc/proc0/inst_exe_next.is_store {-radix hexadecimal} /tb_proc/proc0/inst_exe_next.is_reg_reg {-radix hexadecimal} /tb_proc/proc0/inst_exe_next.is_mul {-radix hexadecimal} /tb_proc/proc0/inst_exe_next.immediate {-radix hexadecimal}} /tb_proc/proc0/inst_exe_next
add wave -noupdate -radix hexadecimal /tb_proc/proc0/inst_mul_next
add wave -noupdate -radix hexadecimal /tb_proc/proc0/inst_mem_next
add wave -noupdate -radix hexadecimal /tb_proc/proc0/inst_wb_next
add wave -noupdate -divider Fetch
add wave -noupdate -radix hexadecimal /tb_proc/proc0/fetch_inst/inst_fetched_out
add wave -noupdate -radix hexadecimal /tb_proc/proc0/fetch_inst/program_counter
add wave -noupdate -divider Decode
add wave -noupdate -radix hexadecimal /tb_proc/proc0/decode_inst/inst_fetched_in
add wave -noupdate -expand -group {Inst Type} /tb_proc/proc0/decode_inst/is_r
add wave -noupdate -expand -group {Inst Type} /tb_proc/proc0/decode_inst/is_i
add wave -noupdate -expand -group {Inst Type} /tb_proc/proc0/decode_inst/is_u
add wave -noupdate -expand -group {Inst Type} /tb_proc/proc0/decode_inst/is_s
add wave -noupdate -expand -group {Inst Type} /tb_proc/proc0/decode_inst/is_b
add wave -noupdate -radix hexadecimal /tb_proc/proc0/decode_inst/imm
add wave -noupdate /tb_proc/proc0/decode_inst/func3
add wave -noupdate -radix decimal /tb_proc/proc0/decode_inst/src_reg_1
add wave -noupdate -radix decimal /tb_proc/proc0/decode_inst/src_reg_2
add wave -noupdate -radix decimal /tb_proc/proc0/decode_inst/dst_reg
add wave -noupdate -group {Hazard Control} /tb_proc/proc0/decode_inst/hazard
add wave -noupdate -group {Hazard Control} /tb_proc/proc0/decode_inst/exe_hazard
add wave -noupdate -group {Hazard Control} /tb_proc/proc0/decode_inst/mem_hazard
add wave -noupdate -childformat {{/tb_proc/proc0/decode_inst/inst_dec_out.src_data_1 -radix hexadecimal} {/tb_proc/proc0/decode_inst/inst_dec_out.src_data_2 -radix hexadecimal} {/tb_proc/proc0/decode_inst/inst_dec_out.dst_reg -radix decimal} {/tb_proc/proc0/decode_inst/inst_dec_out.dst_reg_data -radix hexadecimal}} -subitemconfig {/tb_proc/proc0/decode_inst/inst_dec_out.src_data_1 {-height 13 -radix hexadecimal} /tb_proc/proc0/decode_inst/inst_dec_out.src_data_2 {-height 13 -radix hexadecimal} /tb_proc/proc0/decode_inst/inst_dec_out.dst_reg {-height 13 -radix decimal} /tb_proc/proc0/decode_inst/inst_dec_out.dst_reg_data {-height 13 -radix hexadecimal}} /tb_proc/proc0/decode_inst/inst_dec_out
TreeUpdate [SetDefaultTree]
quietly WaveActivateNextPane
add wave -noupdate -divider {Register File}
add wave -noupdate -radix hexadecimal -childformat {{{/tb_proc/proc0/decode_inst/reg_file/registers[31]} -radix hexadecimal} {{/tb_proc/proc0/decode_inst/reg_file/registers[30]} -radix hexadecimal} {{/tb_proc/proc0/decode_inst/reg_file/registers[29]} -radix hexadecimal} {{/tb_proc/proc0/decode_inst/reg_file/registers[28]} -radix hexadecimal} {{/tb_proc/proc0/decode_inst/reg_file/registers[27]} -radix hexadecimal} {{/tb_proc/proc0/decode_inst/reg_file/registers[26]} -radix hexadecimal} {{/tb_proc/proc0/decode_inst/reg_file/registers[25]} -radix hexadecimal} {{/tb_proc/proc0/decode_inst/reg_file/registers[24]} -radix hexadecimal} {{/tb_proc/proc0/decode_inst/reg_file/registers[23]} -radix hexadecimal} {{/tb_proc/proc0/decode_inst/reg_file/registers[22]} -radix hexadecimal} {{/tb_proc/proc0/decode_inst/reg_file/registers[21]} -radix hexadecimal} {{/tb_proc/proc0/decode_inst/reg_file/registers[20]} -radix hexadecimal} {{/tb_proc/proc0/decode_inst/reg_file/registers[19]} -radix hexadecimal} {{/tb_proc/proc0/decode_inst/reg_file/registers[18]} -radix hexadecimal} {{/tb_proc/proc0/decode_inst/reg_file/registers[17]} -radix hexadecimal} {{/tb_proc/proc0/decode_inst/reg_file/registers[16]} -radix hexadecimal} {{/tb_proc/proc0/decode_inst/reg_file/registers[15]} -radix hexadecimal} {{/tb_proc/proc0/decode_inst/reg_file/registers[14]} -radix hexadecimal} {{/tb_proc/proc0/decode_inst/reg_file/registers[13]} -radix hexadecimal} {{/tb_proc/proc0/decode_inst/reg_file/registers[12]} -radix hexadecimal} {{/tb_proc/proc0/decode_inst/reg_file/registers[11]} -radix hexadecimal} {{/tb_proc/proc0/decode_inst/reg_file/registers[10]} -radix hexadecimal} {{/tb_proc/proc0/decode_inst/reg_file/registers[9]} -radix hexadecimal} {{/tb_proc/proc0/decode_inst/reg_file/registers[8]} -radix hexadecimal} {{/tb_proc/proc0/decode_inst/reg_file/registers[7]} -radix hexadecimal} {{/tb_proc/proc0/decode_inst/reg_file/registers[6]} -radix hexadecimal} {{/tb_proc/proc0/decode_inst/reg_file/registers[5]} -radix hexadecimal} {{/tb_proc/proc0/decode_inst/reg_file/registers[4]} -radix hexadecimal} {{/tb_proc/proc0/decode_inst/reg_file/registers[3]} -radix hexadecimal} {{/tb_proc/proc0/decode_inst/reg_file/registers[2]} -radix hexadecimal} {{/tb_proc/proc0/decode_inst/reg_file/registers[1]} -radix hexadecimal} {{/tb_proc/proc0/decode_inst/reg_file/registers[0]} -radix hexadecimal}} -subitemconfig {{/tb_proc/proc0/decode_inst/reg_file/registers[31]} {-radix hexadecimal} {/tb_proc/proc0/decode_inst/reg_file/registers[30]} {-radix hexadecimal} {/tb_proc/proc0/decode_inst/reg_file/registers[29]} {-radix hexadecimal} {/tb_proc/proc0/decode_inst/reg_file/registers[28]} {-radix hexadecimal} {/tb_proc/proc0/decode_inst/reg_file/registers[27]} {-radix hexadecimal} {/tb_proc/proc0/decode_inst/reg_file/registers[26]} {-radix hexadecimal} {/tb_proc/proc0/decode_inst/reg_file/registers[25]} {-radix hexadecimal} {/tb_proc/proc0/decode_inst/reg_file/registers[24]} {-radix hexadecimal} {/tb_proc/proc0/decode_inst/reg_file/registers[23]} {-radix hexadecimal} {/tb_proc/proc0/decode_inst/reg_file/registers[22]} {-radix hexadecimal} {/tb_proc/proc0/decode_inst/reg_file/registers[21]} {-radix hexadecimal} {/tb_proc/proc0/decode_inst/reg_file/registers[20]} {-radix hexadecimal} {/tb_proc/proc0/decode_inst/reg_file/registers[19]} {-radix hexadecimal} {/tb_proc/proc0/decode_inst/reg_file/registers[18]} {-radix hexadecimal} {/tb_proc/proc0/decode_inst/reg_file/registers[17]} {-radix hexadecimal} {/tb_proc/proc0/decode_inst/reg_file/registers[16]} {-radix hexadecimal} {/tb_proc/proc0/decode_inst/reg_file/registers[15]} {-radix hexadecimal} {/tb_proc/proc0/decode_inst/reg_file/registers[14]} {-radix hexadecimal} {/tb_proc/proc0/decode_inst/reg_file/registers[13]} {-radix hexadecimal} {/tb_proc/proc0/decode_inst/reg_file/registers[12]} {-radix hexadecimal} {/tb_proc/proc0/decode_inst/reg_file/registers[11]} {-radix hexadecimal} {/tb_proc/proc0/decode_inst/reg_file/registers[10]} {-radix hexadecimal} {/tb_proc/proc0/decode_inst/reg_file/registers[9]} {-radix hexadecimal} {/tb_proc/proc0/decode_inst/reg_file/registers[8]} {-radix hexadecimal} {/tb_proc/proc0/decode_inst/reg_file/registers[7]} {-radix hexadecimal} {/tb_proc/proc0/decode_inst/reg_file/registers[6]} {-radix hexadecimal} {/tb_proc/proc0/decode_inst/reg_file/registers[5]} {-radix hexadecimal} {/tb_proc/proc0/decode_inst/reg_file/registers[4]} {-radix hexadecimal} {/tb_proc/proc0/decode_inst/reg_file/registers[3]} {-radix hexadecimal} {/tb_proc/proc0/decode_inst/reg_file/registers[2]} {-radix hexadecimal} {/tb_proc/proc0/decode_inst/reg_file/registers[1]} {-radix hexadecimal} {/tb_proc/proc0/decode_inst/reg_file/registers[0]} {-radix hexadecimal}} /tb_proc/proc0/decode_inst/reg_file/registers
add wave -noupdate -radix hexadecimal /tb_proc/proc0/decode_inst/reg_file/src_data_1
add wave -noupdate -radix hexadecimal /tb_proc/proc0/decode_inst/reg_file/src_data_2
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {7829 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 326
configure wave -valuecolwidth 70
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {30535 ps}
