import constants_pkg::*;
import instruction_pkg::*;

module execute_stage (
  input logic clk,
  input logic rst,
  input inst_decoded_t inst_exe_in,
  output inst_decoded_t inst_exe_out
);

assign inst_exe_out = inst_exe_in;

logic [ARCH_LEN-1:0] op1, op2;

always_comb begin
    op1 <= inst_exe_in.src_data_2;

    if(inst_exe_in.is_i) op2 <= inst_exe_in.immediate;
    else op2 <= inst_exe_in.src_data_2;
end



alu alu_inst (
  .operand1(op1),
  .operand2(op2),
  .is_i(inst_exe_in.is_i
  .alu_op3(inst_exe_in.func3),
  .alu_op7(inst_exe_in.func7),
  .alu_result(alu_result)
);

endmodule
