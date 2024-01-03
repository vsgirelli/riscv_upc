// top_level_module.v
module processor_model (
  input wire clk,
  input wire rst
  // ... other input/output ports
);

fetch_stage fetch_inst (
  .clk(clk),
  .rst(rst)
  // ... other inputs/outputs
);

decode_stage decode_inst (
  .clk(clk),
  .rst(rst),
  .instruction(fetch_inst.instruction) // Connect fetch output to decode input
  // ... other inputs/outputs
);

execute_stage execute_inst (
  .clk(clk),
  .rst(rst),
  .alu_op(decode_inst.alu_op),
  .operand1(decode_inst.operand1), // Connect decode output to execute input
  .operand2(decode_inst.operand2)
  // ... other inputs/outputs
);

memory_stage memory_inst (
  .clk(clk),
  .rst(rst),
  .destination_address(decode_inst.destination_address),
  .mem_write_enable(decode_inst.mem_write_enable),
  .data_in(execute_inst.alu_result) // Connect execute output to memory input
  // ... other inputs/outputs
);

write_back_stage write_back_inst (
  .clk(clk),
  .rst(rst),
  .destination_register(decode_inst.destination_register),
  .regb_write_enable(decode_inst.regb_write_enable),
  .data_in(execute_inst.alu_result) // Connect memory output to write-back input
  // TODO it could be also that the data in receives from memory_inst.data_out
);

// Connect pipeline stages
//   // ...

endmodule
