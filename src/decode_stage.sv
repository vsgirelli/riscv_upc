import constants_pkg::*;
import instruction_pkg::*;

module decode_stage (
  input logic clk,
  input logic rst,

  // instructions in and out of stage
  input logic [INST_LEN-1:0] inst_fetched_in,
  output inst_decoded_t inst_dec_out,
  input inst_decoded_t inst_wb_in,

  // stalls
  output logic stall_dec_out,

  // bypasses from EXE and MEM
  input inst_decoded_t exe_bypass,
  input inst_decoded_t mem_bypass
  // ... other input/output ports
);

logic [$clog2(REG_FILE_LEN)-1:0] src_reg_1; 
logic [$clog2(REG_FILE_LEN)-1:0] src_reg_2; 
logic [$clog2(REG_FILE_LEN)-1:0] dst_reg; 


// Decoding instruction fields // TODO just based on their code to implement the bypass logic
assign opcode    = inst_fetched_in[6:0];
assign src_reg_1 = opcode == 7'h37 ? 0 : inst_fetched_in[19:15];
assign src_reg_2 = inst_fetched_in[24:20];
assign dst_reg   = inst_fetched_in[11:7];

assign inst_dec_out.valid       = ~stall_dec_out ? 1 : 0; // TODO
assign inst_dec_out.is_reg_reg  = opcode == 7'h33 ? inst_dec_out.valid : 0;
assign inst_dec_out.is_load     = opcode == 7'h03 ? inst_dec_out.valid : 0;
assign inst_dec_out.is_store    = opcode == 7'h23 ? inst_dec_out.valid : 0;
assign inst_dec_out.is_mul      = opcode == 7'h33 ? inst_dec_out.valid : 0;
//assign inst_dec_out.isBr  = opcode == 7'h63 ? inst_dec_out.valid : 0;
//assign inst_dec_out.isRrw = opcode == 7'h3b ? inst_dec_out.valid : 0;
//assign inst_dec_out.isIm  = opcode == 7'h13 | opcode == 7'h37 ? inst_dec_out.valid : 0;
//assign inst_dec_out.isSys = opcode == 7'h73 ? inst_dec_out.valid : 0;
  
// Verifying dependency between inst_dec.src_data_1/src_data_2 and inst_exe.dst_reg
assign dep_src1_exe = exe_bypass.valid & exe_bypass.reg_write_enable & (src_reg_1 == exe_bypass.dst_reg); 
assign dep_src2_exe = exe_bypass.valid & exe_bypass.reg_write_enable & (src_reg_2 == exe_bypass.dst_reg);
assign dep_dst_exe  = exe_bypass.valid & exe_bypass.reg_write_enable & (dst_reg   == exe_bypass.dst_reg); 

assign stall_dec_out = dep_src1_exe | dep_src2_exe | dep_dst_exe;

// Verifying dependency between inst_dec.src_data_1/src_data_2 and inst_mem.dst_reg
assign dep_src1_mem = mem_bypass.valid & mem_bypass.reg_write_enable & (src_reg_1 == mem_bypass.dst_reg); 
assign dep_src2_mem = mem_bypass.valid & mem_bypass.reg_write_enable & (src_reg_2 == mem_bypass.dst_reg);
assign dep_dst_mem  = mem_bypass.valid & mem_bypass.reg_write_enable & (dst_reg   == mem_bypass.dst_reg); 


// TODO expand bypass logic to verify between mem and exe hazards
// and if there's a hazard then perform the data updates

endmodule
