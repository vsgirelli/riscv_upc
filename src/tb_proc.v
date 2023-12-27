`timescale 1ns / 1ps

// TEST BENCH MODULE
// Here we instantiate the whole processor, 
// set the clock, the reset, and start processor

module tb_proc
#(
  parameter CORE_CLOCK_PERIOD = 4
)
() ;

  logic clk;
  logic res = 1;

  always #(CORE_CLOCK_PERIOD/2)
    clk = ~clk;

  initial res = 1;
  initial clk = 1;

  integer i = 1;

  logic nclk;
  assign nclk = ~clk;
  always @(posedge nclk) begin
    if (i)
      i <= i-1;
    else
      res <= 0;
  end

  processor_module proc0 (
    .clk,
    .res
  );

endmodule
