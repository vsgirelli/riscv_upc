`timescale 1ns / 1ps

// TEST BENCH MODULE
// Here we instantiate the whole processor, 
// set the clock, the rstet, and start processor

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

  icache icache0 (
    .clk,
    .rst
  );

endmodule

