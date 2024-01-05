import config_pkg::*;
import instruction_pkg::*;

module fetch_stage (
  input logic clk,
  input logic rst,
  output inst_fetched_t inst_fetched_out
);

reg [31:0] program_counter;

always @(posedge clk or posedge rst) begin
  if (rst) begin
  end
end

endmodule
