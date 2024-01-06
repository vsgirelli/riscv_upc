import config_pkg::*;
import instruction_pkg::*;

module execute_stage (
  input logic clk,
  input logic rst,
  input inst_decoded_t inst_exe_in,
  output inst_decoded_t inst_exe_out
);

inst_exe_out = inst_exe_in;
/*alu alu_inst (
  .operand1(operand1),
  .operand2(operand2),
  .alu_op(alu_op),
  .alu_result(alu_result)
);*/

endmodule
