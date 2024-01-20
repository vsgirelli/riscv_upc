import constants_pkg::*;
import structure_pkg::*;

module hazard_module (
  input logic clk,
  input logic rst,

  // we basically compare the current inst of each stage to check dependencies

  // instructions in or out decode_stage
  input inst_decoded_t inst_dec_out,
  // instructions in or out execute_stage
  input inst_decoded_t inst_exe_out, 
  // instructions in or out memory_stage
  input inst_decoded_t inst_mem_out,

  // bypasses
  output bypass_t exe_bypass,
  output bypass_t mem_bypass,
  output bypass_t ltu_bypass, // load_to_use_hazard bypass (insert bubble and then bypass)

  // stalls
  // these stalls make the inst_x in the processor to remain the same
  output logic load_to_use_hazard,

  // exceptions TODO
  output logic kill_fetch,
  output logic kill_dec,
  output logic kill_exe,
  output logic kill_mem,
  output logic kill_wb // we don't have WB stage but we have an inst_wb_in in the decode_stage

);

// We differentiate cases that need stall from cases that need just a bypass
// by calling the former "hazard" and the latter "bypass"
// TODO check slide 76 if we cover all the cases

// load_to_use_hazard
// ltu = load to use (for both R-type and Stores)
assign dep_src1_ltu = inst_exe_out.valid & inst_exe_out.is_load & (inst_dec_out.src_reg_1 == inst_exe_out.dst_reg) & (inst_exe_out.dst_reg != 0);
assign dep_src2_ltu = inst_exe_out.valid & inst_exe_out.is_load & (inst_dec_out.src_reg_2 == inst_exe_out.dst_reg) & (inst_exe_out.dst_reg != 0);
assign load_to_use_hazard = dep_src1_ltu | dep_src2_ltu;
// TODO check if timings are correct, if data is changing correctly since
  // we're inserting a bubble and the dependency becomes a 2 stage dependency
  // that needs bypass
assign ltu_bypass.dep_src1 = dep_src1_ltu;
assign ltu_bypass.dep_src2 = dep_src2_ltu;

// R-type followed by Store (distance of 1 bypass)
// TODO the same of below, store is just a more specific case
// dependency between R-type dst and Store base address
assign dep_src1_sw = inst_exe_out.valid & inst_exe_out.is_reg_reg & inst_dec_out.is_store & (inst_dec_out.src_reg_1 == inst_exe_out.dst_reg) & (inst_exe_out.dst_reg != 0);
// dependency between R-type dst and Store data to be written (src1)
assign dep_src2_sw = inst_exe_out.valid & inst_exe_out.is_reg_reg & inst_dec_out.is_store & (inst_dec_out.src_reg_2 == inst_exe_out.dst_reg) & (inst_exe_out.dst_reg != 0);
/*
always_comb begin
  // bypass from inst_exe_out.dst_reg_data to inst_dec_out.src_data_1 to calculate store address
  if (dep_src1_sw) inst_dec_out.src_data_1 = inst_exe_out.dst_reg_data;
  // bypass from inst_exe_out.dst_reg_data to inst_dec_out.src_data_2 to store data
  if (dep_src2_sw) inst_dec_out.src_data_2 = inst_exe_out.dst_reg_data;
end
*/

// Verifying bypass between inst_dec.src_data_1/src_data_2 and inst_exe.dst_reg
// The flag reg_write_enable guarantees that is a is_reg_reg inst executing on the execute_stage
// The dependency is between consecutive instructions
assign dep_src1_exe = inst_exe_out.valid & inst_exe_out.reg_write_enable & (inst_dec_out.src_reg_1 == inst_exe_out.dst_reg) & (inst_exe_out.dst_reg != 0); // TODO maybe "0" is bad
assign dep_src2_exe = inst_exe_out.valid & inst_exe_out.reg_write_enable & (inst_dec_out.src_reg_2 == inst_exe_out.dst_reg) & (inst_exe_out.dst_reg != 0);
//assign dep_dst_exe  = inst_exe_out.valid & inst_exe_out.reg_write_enable & (inst_dec_out.dst_reg   == inst_exe_out.dst_reg) & (inst_exe_out.dst_reg != 0);
assign exe_bypass.dep_src1 = dep_src1_exe;
assign exe_bypass.dep_src2 = dep_src2_exe;

// Verifying bypass between inst_dec.src_data_1/src_data_2 and inst_mem.dst_reg
// The flag reg_write_enable guarantees that is a load executing on the memory_stage
// or a R-type instruction
// Distance 2 bypass 
assign dep_src1_mem = inst_mem_out.valid & inst_mem_out.reg_write_enable & (inst_dec_out.src_reg_1 == inst_mem_out.dst_reg) & (inst_mem_out.dst_reg != 0);
assign dep_src2_mem = inst_mem_out.valid & inst_mem_out.reg_write_enable & (inst_dec_out.src_reg_2 == inst_mem_out.dst_reg) & (inst_mem_out.dst_reg != 0);
//assign dep_dst_mem  = inst_mem_out.valid & inst_mem_out.reg_write_enable & (inst_dec_out.dst_reg   == inst_mem_out.dst_reg) & (inst_mem_out.dst_reg != 0);
assign mem_bypass.dep_src1 = dep_src1_mem;
assign mem_bypass.dep_src2 = dep_src2_mem;

endmodule
