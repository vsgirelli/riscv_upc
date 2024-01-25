import constants_pkg::*;
import structure_pkg::*;

module execute_stage (
  input logic clk,
  input logic rst,
  input  inst_decoded_t inst_exe_in,
  output inst_decoded_t inst_exe_out,

  output logic br_tk_out, // branch taken
  output logic [ARCH_LEN-1:0] pc_br_tk_out  // branch taken target address
);

logic negative, zero;
logic [ARCH_LEN-1:0] op1, op2;
logic [ARCH_LEN-1:0] alu_result;
logic [2:0] alu_op;
logic [6:0] alu_mod;

// normal ALU 
always_comb begin
  inst_exe_out = inst_exe_in;
  op1 = inst_exe_in.src_data_1;
  op2 = ((inst_exe_in.valid & (inst_exe_in.is_i | inst_exe_in.is_s)) ? inst_exe_in.immediate : inst_exe_in.src_data_2);
  inst_exe_out.dst_reg_data   = alu_result;
  inst_exe_out.reg_data_ready = (inst_exe_in.is_r | inst_exe_in.is_i) & ~(inst_exe_in.is_s | inst_exe_in.is_l | inst_exe_in.is_b);

  // branch-related
  pc_br_tk_out = inst_exe_in.pc + inst_exe_in.immediate;
  br_tk_out = ((inst_exe_in.valid & inst_exe_in.is_b & zero) ? 1 : 0); 
  inst_exe_out.valid = ((inst_exe_in.valid & ~(br_tk_out)) ? 1 : 0);

  // Logic to force add in ALU for mem operations
  alu_op = inst_exe_in.is_s | inst_exe_in.is_l ? 3'b000 : inst_exe_in.func3;
  alu_mod = inst_exe_in.is_s | inst_exe_in.is_l ? 7'b0000000 : inst_exe_in.func7;

  if (rst) begin
    br_tk_out = 0;
  end
end

alu alu_inst (
  .clk(clk),

  .operand1(op1),
  .operand2(op2),
  .alu_op3(alu_op),
  .alu_op7(alu_mod),
  .alu_result(alu_result),
  .negative(negative),
  .zero(zero)
);


endmodule
