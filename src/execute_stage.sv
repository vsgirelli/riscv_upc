import constants_pkg::*;
import structure_pkg::*;

module execute_stage (
  input logic clk,
  input logic rst,
  input inst_decoded_t  inst_exe_in,
  output inst_decoded_t inst_exe_out,
  output logic kill_exe_out, // branch taken
  output logic pc_br_tk_out  // branch taken PC address
);


logic [ARCH_LEN-1:0] op1, op2;
logic [ARCH_LEN-1:0] alu_result;

always_comb begin
  inst_exe_out = inst_exe_in;
  if (inst_exe_in.valid) begin
    if (~inst_exe_in.is_b) begin

      op1 <= inst_exe_in.src_data_1;

      if(inst_exe_in.is_i) op2 <= inst_exe_in.immediate;
      else op2 <= inst_exe_in.src_data_2;

      inst_exe_out.dst_reg_data <= alu_result;
      inst_exe_out.reg_data_ready <= (inst_exe_in.is_r | inst_exe_in.is_i) & ~(inst_exe_in.is_s | inst_exe_in.is_l);
    end
    else begin
      if (~alu_result) begin
        pc_br_tk_out = inst_exe_in.pc + inst_exe_in.immediate;
        kill_exe_out = 1; 
        inst_exe_out.valid = 0;
      end
    end

  end
  else inst_exe_out.valid = 0;
  // TODO mul
end



alu alu_inst (
  .clk(clk),

  .operand1(op1),
  .operand2(op2),
  .alu_op3(inst_exe_in.func3),
  .alu_op7(inst_exe_in.func7),
  .alu_result(alu_result)
);


endmodule
