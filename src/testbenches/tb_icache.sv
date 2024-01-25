`timescale 1ns / 1ps

// TEST BENCH MODULE
// Here we instantiate the whole processor, 
// set the clock, the rstet, and start processor
import constants_pkg::*;

module tb_icache
#(
  parameter CORE_CLOCK_PERIOD = 4
)
() ;

  logic clk;
  logic rst = 1;

  always #(CORE_CLOCK_PERIOD/2)
    clk = ~clk;

  initial rst = 1;
  initial clk = 1;

  integer i = 1;

  logic nclk;
  assign nclk = ~clk;
  always @(posedge nclk) begin
    if (i)
      i <= i-1;
    else
      rst <= 0;
  end

  const logic [PHY_LEN-1:0] addr = 20'h0_0010;
  logic out_miss, in_enable;
  logic [INST_LEN-1:0] instruction;

  instruction_bus ibus();

  icache icache0 (
    .clk,
    .rst,

    .addr(addr),
    .enable(in_enable),

    .instr_data(instruction),
    .miss(out_miss),

    .bus(ibus.consumer)
  );

assign in_enable = 1;

  // memory_logic

endmodule

