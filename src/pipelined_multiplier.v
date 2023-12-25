// Artificial 5-stage multiplier
module PipelinedMultiplier #(parameter WIDTH = 32)(
  input wire clk,
  input wire rst,
  input wire [WIDTH-1:0] A,
  input wire [WIDTH-1:0] B,
  output reg [2*WIDTH-1:0] P // The output is 64-bit and it should match on the calling modules as well
);

reg [2*WIDTH-1:0] stage1, stage2, stage3, stage4, stage5;

always @(posedge clk or negedge rst) begin
  if (!rst) begin
    // Reset all pipeline stages
    stage1 <= 2*WIDTH'b0;
    stage2 <= 2*WIDTH'b0;
    stage3 <= 2*WIDTH'b0;
    stage4 <= 2*WIDTH'b0;
    stage5 <= 2*WIDTH'b0;
  end else begin
    // Stage 1
    stage1 = A * B;
    // Stage 2
    stage2 = stage1;
    // Stage 3
    stage3 = stage2;
    // Stage 4
    stage4 = stage3;
    // Stage 5 (Final result)
    P = stage4;
  end
end

endmodule
