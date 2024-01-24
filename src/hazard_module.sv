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

logic dep_src1_ltu, dep_src2_ltu, dep_src1_exe, dep_src2_exe, dep_src1_mem, dep_src2_mem;
always_comb begin
  // load_to_use_hazard
  // ltu = load to use (for both R-type and Stores)
  // the insertion of a bubble in the execute_stage will generate a mem_bypass
  // case that will be captured in the next cycle
  dep_src1_ltu = inst_exe_out.valid & inst_exe_out.is_l & (inst_dec_out.src_reg_1 == inst_exe_out.dst_reg) & (inst_exe_out.dst_reg != 0);
  dep_src2_ltu = inst_exe_out.valid & inst_exe_out.is_l & (inst_dec_out.src_reg_2 == inst_exe_out.dst_reg) & (inst_exe_out.dst_reg != 0);
  load_to_use_hazard = dep_src1_ltu | dep_src2_ltu;

  // Verifying bypass between inst_dec.src_data_1/src_data_2 and inst_exe.dst_reg
  // The flag reg_write_enable guarantees that is a is_r inst executing on the execute_stage
  // Distance 1 bypass
  dep_src1_exe = inst_exe_out.valid & inst_exe_out.reg_write_enable & (inst_dec_out.src_reg_1 == inst_exe_out.dst_reg) & (inst_exe_out.dst_reg != 0);
  dep_src2_exe = inst_exe_out.valid & inst_exe_out.reg_write_enable & (inst_dec_out.src_reg_2 == inst_exe_out.dst_reg) & (inst_exe_out.dst_reg != 0);
  exe_bypass.dep_src1 = dep_src1_exe;
  exe_bypass.dep_src2 = dep_src2_exe;

  // Verifying bypass between inst_dec.src_data_1/src_data_2 and inst_mem.dst_reg
  // The flag reg_write_enable guarantees that is a load executing on the memory_stage
  // or a R-type instruction
  // Distance 2 bypass
  dep_src1_mem = inst_mem_out.valid & inst_mem_out.reg_write_enable & (inst_dec_out.src_reg_1 == inst_mem_out.dst_reg) & (inst_mem_out.dst_reg != 0);
  dep_src2_mem = inst_mem_out.valid & inst_mem_out.reg_write_enable & (inst_dec_out.src_reg_2 == inst_mem_out.dst_reg) & (inst_mem_out.dst_reg != 0);
  mem_bypass.dep_src1 = dep_src1_mem;
  mem_bypass.dep_src2 = dep_src2_mem;

  if (rst) begin
    load_to_use_hazard  = 0;
    exe_bypass.dep_src1 = 0;
    exe_bypass.dep_src2 = 0;
    mem_bypass.dep_src1 = 0;
    mem_bypass.dep_src2 = 0;
  end
end

endmodule
