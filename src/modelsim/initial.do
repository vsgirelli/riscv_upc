onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_proc/proc0/clk
add wave -noupdate /tb_proc/proc0/rst
add wave -noupdate -divider {Decoupling Registers}
add wave -noupdate -radix hexadecimal -childformat {{{/tb_proc/proc0/inst_dec_next[31]} -radix hexadecimal} {{/tb_proc/proc0/inst_dec_next[30]} -radix hexadecimal} {{/tb_proc/proc0/inst_dec_next[29]} -radix hexadecimal} {{/tb_proc/proc0/inst_dec_next[28]} -radix hexadecimal} {{/tb_proc/proc0/inst_dec_next[27]} -radix hexadecimal} {{/tb_proc/proc0/inst_dec_next[26]} -radix hexadecimal} {{/tb_proc/proc0/inst_dec_next[25]} -radix hexadecimal} {{/tb_proc/proc0/inst_dec_next[24]} -radix hexadecimal} {{/tb_proc/proc0/inst_dec_next[23]} -radix hexadecimal} {{/tb_proc/proc0/inst_dec_next[22]} -radix hexadecimal} {{/tb_proc/proc0/inst_dec_next[21]} -radix hexadecimal} {{/tb_proc/proc0/inst_dec_next[20]} -radix hexadecimal} {{/tb_proc/proc0/inst_dec_next[19]} -radix hexadecimal} {{/tb_proc/proc0/inst_dec_next[18]} -radix hexadecimal} {{/tb_proc/proc0/inst_dec_next[17]} -radix hexadecimal} {{/tb_proc/proc0/inst_dec_next[16]} -radix hexadecimal} {{/tb_proc/proc0/inst_dec_next[15]} -radix hexadecimal} {{/tb_proc/proc0/inst_dec_next[14]} -radix hexadecimal} {{/tb_proc/proc0/inst_dec_next[13]} -radix hexadecimal} {{/tb_proc/proc0/inst_dec_next[12]} -radix hexadecimal} {{/tb_proc/proc0/inst_dec_next[11]} -radix hexadecimal} {{/tb_proc/proc0/inst_dec_next[10]} -radix hexadecimal} {{/tb_proc/proc0/inst_dec_next[9]} -radix hexadecimal} {{/tb_proc/proc0/inst_dec_next[8]} -radix hexadecimal} {{/tb_proc/proc0/inst_dec_next[7]} -radix hexadecimal} {{/tb_proc/proc0/inst_dec_next[6]} -radix hexadecimal} {{/tb_proc/proc0/inst_dec_next[5]} -radix hexadecimal} {{/tb_proc/proc0/inst_dec_next[4]} -radix hexadecimal} {{/tb_proc/proc0/inst_dec_next[3]} -radix hexadecimal} {{/tb_proc/proc0/inst_dec_next[2]} -radix hexadecimal} {{/tb_proc/proc0/inst_dec_next[1]} -radix hexadecimal} {{/tb_proc/proc0/inst_dec_next[0]} -radix hexadecimal}} -subitemconfig {{/tb_proc/proc0/inst_dec_next[31]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/inst_dec_next[30]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/inst_dec_next[29]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/inst_dec_next[28]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/inst_dec_next[27]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/inst_dec_next[26]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/inst_dec_next[25]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/inst_dec_next[24]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/inst_dec_next[23]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/inst_dec_next[22]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/inst_dec_next[21]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/inst_dec_next[20]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/inst_dec_next[19]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/inst_dec_next[18]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/inst_dec_next[17]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/inst_dec_next[16]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/inst_dec_next[15]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/inst_dec_next[14]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/inst_dec_next[13]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/inst_dec_next[12]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/inst_dec_next[11]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/inst_dec_next[10]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/inst_dec_next[9]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/inst_dec_next[8]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/inst_dec_next[7]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/inst_dec_next[6]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/inst_dec_next[5]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/inst_dec_next[4]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/inst_dec_next[3]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/inst_dec_next[2]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/inst_dec_next[1]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/inst_dec_next[0]} {-height 13 -radix hexadecimal}} /tb_proc/proc0/inst_dec_next
add wave -noupdate -radix hexadecimal -childformat {{/tb_proc/proc0/inst_exe_next.valid -radix hexadecimal} {/tb_proc/proc0/inst_exe_next.src_data_1 -radix hexadecimal} {/tb_proc/proc0/inst_exe_next.src_data_2 -radix hexadecimal} {/tb_proc/proc0/inst_exe_next.dst_reg -radix hexadecimal} {/tb_proc/proc0/inst_exe_next.dst_reg_data -radix hexadecimal} {/tb_proc/proc0/inst_exe_next.reg_write_enable -radix hexadecimal} {/tb_proc/proc0/inst_exe_next.reg_data_ready -radix hexadecimal} {/tb_proc/proc0/inst_exe_next.func3 -radix hexadecimal} {/tb_proc/proc0/inst_exe_next.func7 -radix hexadecimal} {/tb_proc/proc0/inst_exe_next.is_load -radix hexadecimal} {/tb_proc/proc0/inst_exe_next.is_store -radix hexadecimal} {/tb_proc/proc0/inst_exe_next.is_reg_reg -radix hexadecimal} {/tb_proc/proc0/inst_exe_next.is_mul -radix hexadecimal} {/tb_proc/proc0/inst_exe_next.immediate -radix hexadecimal} {/tb_proc/proc0/inst_exe_next.is_i -radix hexadecimal} {/tb_proc/proc0/inst_exe_next.is_r -radix hexadecimal} {/tb_proc/proc0/inst_exe_next.is_u -radix hexadecimal} {/tb_proc/proc0/inst_exe_next.is_s -radix hexadecimal} {/tb_proc/proc0/inst_exe_next.is_b -radix hexadecimal} {/tb_proc/proc0/inst_exe_next.is_j -radix hexadecimal}} -subitemconfig {/tb_proc/proc0/inst_exe_next.valid {-height 13 -radix hexadecimal} /tb_proc/proc0/inst_exe_next.src_data_1 {-height 13 -radix hexadecimal} /tb_proc/proc0/inst_exe_next.src_data_2 {-height 13 -radix hexadecimal} /tb_proc/proc0/inst_exe_next.dst_reg {-height 13 -radix hexadecimal} /tb_proc/proc0/inst_exe_next.dst_reg_data {-height 13 -radix hexadecimal} /tb_proc/proc0/inst_exe_next.reg_write_enable {-height 13 -radix hexadecimal} /tb_proc/proc0/inst_exe_next.reg_data_ready {-height 13 -radix hexadecimal} /tb_proc/proc0/inst_exe_next.func3 {-height 13 -radix hexadecimal} /tb_proc/proc0/inst_exe_next.func7 {-height 13 -radix hexadecimal} /tb_proc/proc0/inst_exe_next.is_load {-height 13 -radix hexadecimal} /tb_proc/proc0/inst_exe_next.is_store {-height 13 -radix hexadecimal} /tb_proc/proc0/inst_exe_next.is_reg_reg {-height 13 -radix hexadecimal} /tb_proc/proc0/inst_exe_next.is_mul {-height 13 -radix hexadecimal} /tb_proc/proc0/inst_exe_next.immediate {-height 13 -radix hexadecimal} /tb_proc/proc0/inst_exe_next.is_i {-height 13 -radix hexadecimal} /tb_proc/proc0/inst_exe_next.is_r {-height 13 -radix hexadecimal} /tb_proc/proc0/inst_exe_next.is_u {-height 13 -radix hexadecimal} /tb_proc/proc0/inst_exe_next.is_s {-height 13 -radix hexadecimal} /tb_proc/proc0/inst_exe_next.is_b {-height 13 -radix hexadecimal} /tb_proc/proc0/inst_exe_next.is_j {-height 13 -radix hexadecimal}} /tb_proc/proc0/inst_exe_next
add wave -noupdate -radix hexadecimal /tb_proc/proc0/inst_mul_next
add wave -noupdate -radix hexadecimal /tb_proc/proc0/inst_mem_next
add wave -noupdate -radix hexadecimal /tb_proc/proc0/inst_wb_next
add wave -noupdate -divider Fetch
add wave -noupdate -radix hexadecimal /tb_proc/proc0/fetch_inst/inst_fetched_out
add wave -noupdate -radix hexadecimal /tb_proc/proc0/fetch_inst/program_counter
add wave -noupdate /tb_proc/proc0/fetch_inst/stall_fet_in
add wave -noupdate /tb_proc/proc0/fetch_inst/out_miss
add wave -noupdate -radix hexadecimal -childformat {{{/tb_proc/proc0/fetch_inst/icache0/selectedData[127]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[126]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[125]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[124]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[123]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[122]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[121]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[120]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[119]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[118]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[117]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[116]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[115]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[114]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[113]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[112]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[111]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[110]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[109]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[108]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[107]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[106]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[105]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[104]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[103]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[102]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[101]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[100]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[99]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[98]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[97]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[96]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[95]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[94]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[93]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[92]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[91]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[90]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[89]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[88]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[87]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[86]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[85]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[84]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[83]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[82]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[81]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[80]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[79]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[78]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[77]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[76]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[75]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[74]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[73]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[72]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[71]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[70]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[69]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[68]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[67]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[66]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[65]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[64]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[63]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[62]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[61]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[60]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[59]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[58]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[57]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[56]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[55]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[54]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[53]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[52]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[51]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[50]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[49]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[48]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[47]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[46]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[45]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[44]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[43]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[42]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[41]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[40]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[39]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[38]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[37]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[36]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[35]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[34]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[33]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[32]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[31]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[30]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[29]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[28]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[27]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[26]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[25]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[24]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[23]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[22]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[21]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[20]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[19]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[18]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[17]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[16]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[15]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[14]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[13]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[12]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[11]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[10]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[9]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[8]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[7]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[6]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[5]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[4]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[3]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[2]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[1]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selectedData[0]} -radix hexadecimal}} -subitemconfig {{/tb_proc/proc0/fetch_inst/icache0/selectedData[127]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[126]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[125]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[124]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[123]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[122]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[121]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[120]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[119]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[118]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[117]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[116]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[115]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[114]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[113]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[112]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[111]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[110]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[109]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[108]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[107]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[106]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[105]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[104]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[103]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[102]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[101]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[100]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[99]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[98]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[97]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[96]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[95]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[94]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[93]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[92]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[91]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[90]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[89]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[88]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[87]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[86]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[85]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[84]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[83]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[82]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[81]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[80]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[79]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[78]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[77]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[76]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[75]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[74]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[73]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[72]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[71]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[70]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[69]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[68]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[67]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[66]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[65]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[64]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[63]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[62]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[61]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[60]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[59]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[58]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[57]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[56]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[55]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[54]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[53]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[52]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[51]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[50]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[49]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[48]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[47]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[46]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[45]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[44]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[43]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[42]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[41]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[40]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[39]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[38]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[37]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[36]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[35]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[34]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[33]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[32]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[31]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[30]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[29]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[28]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[27]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[26]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[25]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[24]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[23]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[22]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[21]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[20]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[19]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[18]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[17]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[16]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[15]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[14]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[13]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[12]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[11]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[10]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[9]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[8]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[7]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[6]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[5]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[4]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[3]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[2]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[1]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selectedData[0]} {-height 13 -radix hexadecimal}} /tb_proc/proc0/fetch_inst/icache0/selectedData
add wave -noupdate /tb_proc/proc0/fetch_inst/icache0/state
add wave -noupdate -childformat {{{/tb_proc/proc0/fetch_inst/icache0/selLine[3]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selLine[2]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selLine[1]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/selLine[0]} -radix hexadecimal}} -subitemconfig {{/tb_proc/proc0/fetch_inst/icache0/selLine[3]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selLine[2]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selLine[1]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/selLine[0]} {-height 13 -radix hexadecimal}} /tb_proc/proc0/fetch_inst/icache0/selLine
add wave -noupdate -divider Cache
add wave -noupdate -radix hexadecimal /tb_proc/proc0/fetch_inst/icache0/current_addr
add wave -noupdate -radix hexadecimal -childformat {{{/tb_proc/proc0/fetch_inst/icache0/data[0]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/data[1]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/data[2]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/data[3]} -radix hexadecimal}} -expand -subitemconfig {{/tb_proc/proc0/fetch_inst/icache0/data[0]} {-radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/data[1]} {-radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/data[2]} {-radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/data[3]} {-radix hexadecimal}} /tb_proc/proc0/fetch_inst/icache0/data
add wave -noupdate -radix hexadecimal -childformat {{{/tb_proc/proc0/fetch_inst/icache0/tags[0]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/tags[1]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/tags[2]} -radix hexadecimal} {{/tb_proc/proc0/fetch_inst/icache0/tags[3]} -radix hexadecimal}} -subitemconfig {{/tb_proc/proc0/fetch_inst/icache0/tags[0]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/tags[1]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/tags[2]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/fetch_inst/icache0/tags[3]} {-height 13 -radix hexadecimal}} /tb_proc/proc0/fetch_inst/icache0/tags
add wave -noupdate /tb_proc/proc0/fetch_inst/icache0/valid
add wave -noupdate -divider Memory
add wave -noupdate /tb_proc/proc0/mem0/state
add wave -noupdate -divider Decode
add wave -noupdate -radix hexadecimal /tb_proc/proc0/decode_inst/inst_fetched_in
add wave -noupdate -group {Inst Type} /tb_proc/proc0/decode_inst/is_r
add wave -noupdate -group {Inst Type} /tb_proc/proc0/decode_inst/is_i
add wave -noupdate -group {Inst Type} /tb_proc/proc0/decode_inst/is_u
add wave -noupdate -group {Inst Type} /tb_proc/proc0/decode_inst/is_s
add wave -noupdate -group {Inst Type} /tb_proc/proc0/decode_inst/is_b
add wave -noupdate -radix hexadecimal /tb_proc/proc0/decode_inst/imm
add wave -noupdate /tb_proc/proc0/decode_inst/func3
add wave -noupdate -radix decimal /tb_proc/proc0/decode_inst/src_reg_1
add wave -noupdate -radix decimal /tb_proc/proc0/decode_inst/src_reg_2
add wave -noupdate -radix decimal /tb_proc/proc0/decode_inst/dst_reg
add wave -noupdate -group {Hazard Control} /tb_proc/proc0/decode_inst/hazard
add wave -noupdate -group {Hazard Control} /tb_proc/proc0/decode_inst/exe_hazard
add wave -noupdate -group {Hazard Control} /tb_proc/proc0/decode_inst/mem_hazard
add wave -noupdate -childformat {{/tb_proc/proc0/decode_inst/inst_dec_out.src_data_1 -radix hexadecimal} {/tb_proc/proc0/decode_inst/inst_dec_out.src_data_2 -radix hexadecimal} {/tb_proc/proc0/decode_inst/inst_dec_out.dst_reg -radix decimal} {/tb_proc/proc0/decode_inst/inst_dec_out.dst_reg_data -radix hexadecimal} {/tb_proc/proc0/decode_inst/inst_dec_out.immediate -radix hexadecimal}} -subitemconfig {/tb_proc/proc0/decode_inst/inst_dec_out.src_data_1 {-height 13 -radix hexadecimal} /tb_proc/proc0/decode_inst/inst_dec_out.src_data_2 {-height 13 -radix hexadecimal} /tb_proc/proc0/decode_inst/inst_dec_out.dst_reg {-height 13 -radix decimal} /tb_proc/proc0/decode_inst/inst_dec_out.dst_reg_data {-height 13 -radix hexadecimal} /tb_proc/proc0/decode_inst/inst_dec_out.immediate {-height 13 -radix hexadecimal}} /tb_proc/proc0/decode_inst/inst_dec_out
add wave -noupdate -divider Execute
add wave -noupdate /tb_proc/proc0/execute_inst/inst_exe_in
add wave -noupdate -radix hexadecimal /tb_proc/proc0/execute_inst/op1
add wave -noupdate -radix hexadecimal /tb_proc/proc0/execute_inst/op2
add wave -noupdate -radix hexadecimal /tb_proc/proc0/execute_inst/alu_result
TreeUpdate [SetDefaultTree]
quietly WaveActivateNextPane
add wave -noupdate -divider {Register File}
add wave -noupdate -radix hexadecimal -childformat {{{/tb_proc/proc0/decode_inst/reg_file/registers[31]} -radix hexadecimal} {{/tb_proc/proc0/decode_inst/reg_file/registers[30]} -radix hexadecimal} {{/tb_proc/proc0/decode_inst/reg_file/registers[29]} -radix hexadecimal} {{/tb_proc/proc0/decode_inst/reg_file/registers[28]} -radix hexadecimal} {{/tb_proc/proc0/decode_inst/reg_file/registers[27]} -radix hexadecimal} {{/tb_proc/proc0/decode_inst/reg_file/registers[26]} -radix hexadecimal} {{/tb_proc/proc0/decode_inst/reg_file/registers[25]} -radix hexadecimal} {{/tb_proc/proc0/decode_inst/reg_file/registers[24]} -radix hexadecimal} {{/tb_proc/proc0/decode_inst/reg_file/registers[23]} -radix hexadecimal} {{/tb_proc/proc0/decode_inst/reg_file/registers[22]} -radix hexadecimal} {{/tb_proc/proc0/decode_inst/reg_file/registers[21]} -radix hexadecimal} {{/tb_proc/proc0/decode_inst/reg_file/registers[20]} -radix hexadecimal} {{/tb_proc/proc0/decode_inst/reg_file/registers[19]} -radix hexadecimal} {{/tb_proc/proc0/decode_inst/reg_file/registers[18]} -radix hexadecimal} {{/tb_proc/proc0/decode_inst/reg_file/registers[17]} -radix hexadecimal} {{/tb_proc/proc0/decode_inst/reg_file/registers[16]} -radix hexadecimal} {{/tb_proc/proc0/decode_inst/reg_file/registers[15]} -radix hexadecimal} {{/tb_proc/proc0/decode_inst/reg_file/registers[14]} -radix hexadecimal} {{/tb_proc/proc0/decode_inst/reg_file/registers[13]} -radix hexadecimal} {{/tb_proc/proc0/decode_inst/reg_file/registers[12]} -radix hexadecimal} {{/tb_proc/proc0/decode_inst/reg_file/registers[11]} -radix hexadecimal} {{/tb_proc/proc0/decode_inst/reg_file/registers[10]} -radix hexadecimal} {{/tb_proc/proc0/decode_inst/reg_file/registers[9]} -radix hexadecimal} {{/tb_proc/proc0/decode_inst/reg_file/registers[8]} -radix hexadecimal} {{/tb_proc/proc0/decode_inst/reg_file/registers[7]} -radix hexadecimal} {{/tb_proc/proc0/decode_inst/reg_file/registers[6]} -radix hexadecimal} {{/tb_proc/proc0/decode_inst/reg_file/registers[5]} -radix hexadecimal} {{/tb_proc/proc0/decode_inst/reg_file/registers[4]} -radix hexadecimal} {{/tb_proc/proc0/decode_inst/reg_file/registers[3]} -radix hexadecimal} {{/tb_proc/proc0/decode_inst/reg_file/registers[2]} -radix hexadecimal} {{/tb_proc/proc0/decode_inst/reg_file/registers[1]} -radix hexadecimal} {{/tb_proc/proc0/decode_inst/reg_file/registers[0]} -radix hexadecimal}} -expand -subitemconfig {{/tb_proc/proc0/decode_inst/reg_file/registers[31]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/decode_inst/reg_file/registers[30]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/decode_inst/reg_file/registers[29]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/decode_inst/reg_file/registers[28]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/decode_inst/reg_file/registers[27]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/decode_inst/reg_file/registers[26]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/decode_inst/reg_file/registers[25]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/decode_inst/reg_file/registers[24]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/decode_inst/reg_file/registers[23]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/decode_inst/reg_file/registers[22]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/decode_inst/reg_file/registers[21]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/decode_inst/reg_file/registers[20]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/decode_inst/reg_file/registers[19]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/decode_inst/reg_file/registers[18]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/decode_inst/reg_file/registers[17]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/decode_inst/reg_file/registers[16]} {-radix hexadecimal} {/tb_proc/proc0/decode_inst/reg_file/registers[15]} {-radix hexadecimal} {/tb_proc/proc0/decode_inst/reg_file/registers[14]} {-radix hexadecimal} {/tb_proc/proc0/decode_inst/reg_file/registers[13]} {-radix hexadecimal} {/tb_proc/proc0/decode_inst/reg_file/registers[12]} {-radix hexadecimal} {/tb_proc/proc0/decode_inst/reg_file/registers[11]} {-radix hexadecimal} {/tb_proc/proc0/decode_inst/reg_file/registers[10]} {-radix hexadecimal} {/tb_proc/proc0/decode_inst/reg_file/registers[9]} {-radix hexadecimal} {/tb_proc/proc0/decode_inst/reg_file/registers[8]} {-radix hexadecimal} {/tb_proc/proc0/decode_inst/reg_file/registers[7]} {-radix hexadecimal} {/tb_proc/proc0/decode_inst/reg_file/registers[6]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/decode_inst/reg_file/registers[5]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/decode_inst/reg_file/registers[4]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/decode_inst/reg_file/registers[3]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/decode_inst/reg_file/registers[2]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/decode_inst/reg_file/registers[1]} {-height 13 -radix hexadecimal} {/tb_proc/proc0/decode_inst/reg_file/registers[0]} {-height 13 -radix hexadecimal}} /tb_proc/proc0/decode_inst/reg_file/registers
add wave -noupdate -radix hexadecimal /tb_proc/proc0/decode_inst/reg_file/src_data_1
add wave -noupdate -radix hexadecimal /tb_proc/proc0/decode_inst/reg_file/src_data_2
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {16963 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 382
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
WaveRestoreZoom {2894 ps} {31850 ps}
