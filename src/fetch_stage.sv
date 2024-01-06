import constants_pkg::*;
import instruction_pkg::*;

module fetch_stage (
  input wire clk,
  input wire rst,
  output logic [INST_LEN-1:0] inst_fetched_out,

  input logic stall_fet_in
);

reg [ARCH_LEN-1:0] program_counter;

logic nxtPC;

logic [7:0] temp_mem [1024:0];
//initial
//    $readmemh("instruction_memory.hex", temp_mem);

always_comb begin

    // Default case, PC + 4
    nxtPC <= program_counter + 4;
    inst_fetched_out <= temp_mem[program_counter];

    if(stall_fet_in) 
        nxtPC <= program_counter;
    
    if(rst) begin
        inst_fetched_out <= {INST_LEN{1'b0}};
        nxtPC <= BOOT_ADDR;
	 end

end

always_ff @(posedge clk) begin
	program_counter = nxtPC;
end

endmodule
