import constants_pkg::*;
import structure_pkg::*;

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
const logic [INST_LEN-1:0] addi_1 = 32'b000000000001_00001_000_00001_0010011;  

//$readmemh("instruction_memory.hex", temp_mem);

always_comb begin

    // Default case, PC + 4
    nxtPC <= program_counter + 4;
    inst_fetched_out <= addi_1; //temp_mem[program_counter];

    if(stall_fet_in) 
        nxtPC <= program_counter;
    
    if(rst) begin
        nxtPC <= 32'h0000; // BOOT_ADDR;
        inst_fetched_out <= {INST_LEN{1'b0}};
	 end

end

always_ff @(posedge clk) begin
	program_counter = nxtPC;
end

endmodule
