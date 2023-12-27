module write_back_stage (
  input wire clk,
  input wire rst,
  input wire [4:0] destination_register,
  input wire regb_write_enable,
  input wire [31:0] data_in
);
// Assuming a simple register file
reg [31:0] registers [0:31]; // 32 general-purpose registers

// Write-back logic
always @(posedge clk or negedge rst) begin
  if (!rst) begin
    // Reset logic
    // ... other reset actions
  end else begin
    // Write data to the destination register when write_enable is asserted
    if (regb_write_enable) begin
      registers[destination_register] <= data_in;
    end
  end
end
endmodule

