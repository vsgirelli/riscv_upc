// Artificial 5-stage multiplier
module pipelined_multiplier #(parameter WIDTH = 32)(
  input wire clk,
  input wire rst,
  input wire [WIDTH-1:0] operand1,
  input wire [WIDTH-1:0] operand2,
  output reg [2*WIDTH-1:0] mult_result // The output is 64-bit and it should match on the calling modules as well
);

reg [2*WIDTH-1:0] stage1, stage2, stage3, stage4, stage5;

always @(posedge clk or negedge rst) begin
  if (!rst) begin
    // Reset all pipeline stages
    stage1 <= 2*{WIDTH{1'b0}};
    stage2 <= 2*{WIDTH{1'b0}};
    stage3 <= 2*{WIDTH{1'b0}};
    stage4 <= 2*{WIDTH{1'b0}};
    stage5 <= 2*{WIDTH{1'b0}};
  end else begin
    stage1 = operand1 * operand2;
    stage2 = stage1;
    stage3 = stage2;
    stage4 = stage3;
    mult_result = stage4;
  end
end

endmodule
