import constants_pkg::*;

module fetch_stage (
  input wire clk,
  input wire rst,
  output wire [ILEN-1:0] instruction_out,

  input logic stall_i
);

reg [XLEN-1:0] program_counter;
logic [ILEN-1:0] instruction_fetched;

logic nxtPC;

logic [7:0] temp_mem [1024:0];
initial
    $readmemh("instruction_memory.hex", temp_mem);

assign instruction_out = instruction_fetched;

always_comb begin

    // Default case, PC + 4
    nxtPC <= program_counter + 4;
    instruction_fetched <= temp_mem[program_counter];

    if(stall_i) 
        nxtPC <= program_counter;
    
    if(rst) begin
        instruction_fetched <= {ILEN{1'b0}};
        nxtPC <= BOOT_ADDR;
	 end

end

always_ff @(posedge clk) begin
	program_counter = nxtPC;
end

endmodule
