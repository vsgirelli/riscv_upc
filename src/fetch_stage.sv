import constants_pkg::*;
import structure_pkg::*;

module fetch_stage (
  input wire clk,
  input wire rst,
  output logic [INST_LEN-1:0] inst_fetched_out,

  input logic stall_fet_in,

  output logic [ARCH_LEN-1:0] pc_out,
  instruction_bus.consumer ibus
);

reg [ARCH_LEN-1:0] program_counter;

logic [ARCH_LEN-1:0] nxtPC;
assign pc_out = nxtPC;

logic [7:0] temp_mem [1024:0];
//initial
const logic [INST_LEN-1:0] addi_1 = 32'b000000000001_00001_000_00001_0010011;  
const logic [INST_LEN-1:0] noop = 32'b000000000000_00000_000_00000_0010011;  

//$readmemh("instruction_memory.hex", temp_mem);

logic out_miss, in_enable;
logic [INST_LEN-1:0] icache_instruction;
assign in_enable = 1;

icache icache0 (
  .clk,
  .rst,

  .addr(program_counter[PHY_LEN-1:0]),
  .enable(in_enable),

  .instr_data(icache_instruction),
  .miss(out_miss),

  .ibus
);

always_comb begin

    // Default case, PC + 4
    nxtPC = program_counter + 4;
    inst_fetched_out = icache_instruction; //addi_1; //temp_mem[program_counter];

    if(stall_fet_in | out_miss) begin
        nxtPC = program_counter;
        inst_fetched_out = noop;
    end
    
    if(rst) begin
        nxtPC = 32'h0000; // BOOT_ADDR;
        inst_fetched_out = {INST_LEN{1'b0}};
     end

end

always_ff @(posedge clk) begin
	program_counter = nxtPC;
end

endmodule
