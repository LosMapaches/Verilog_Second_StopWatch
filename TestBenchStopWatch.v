// Lane Schultz
// Digital Electronics Project for the following:
// This is the testbench for the Digital Stop Watch.

`timescale 1ns/1ps

module TestbenchStopWatch(
						  input         Clock,
						  input  [15:0] sw,
						  input         btnC,
						  input         btnU,
						  input         btnD,
						  input         btnR,
						  input         btnL,
						  output [15:0] led,
						  output [ 3:0] an,
						  output [ 6:0] seg
						  );

parameter  CountMax0 = 64'd1000000;   // 100 Hz.
parameter  CountMax1 = CountMax0*10;  // 10  Hz.
parameter  CountMax2 = CountMax1*10;  // 1   Hz
parameter  CountMax3 = CountMax2*10;  // 0.1 Hz

wire [6:0] Segments0;
wire [6:0] Segments1;
wire [6:0] Segments2;
wire [6:0] Segments3;

// Segments counting at 100 Hz.
StopWatch aut(
			  .CountMax(CountMax0),
			  .Segments(Segments0),
			  .Start(btnU),
			  .Stop(btnC),
			  .Reset(btnD),
			  .Clock(Clock)
			  );

// Segments counting at 10 Hz.			   
StopWatch but(
              .CountMax(CountMax1),
     		  .Segments(Segments1),
			  .Start(btnU),
			  .Stop(btnC),
			  .Reset(btnD),
			  .Clock(Clock)
			  );

// Segments counting at 1 Hz.
StopWatch cut(
              .CountMax(CountMax2),
			  .Segments(Segments2),
			  .Start(btnU),
			  .Stop(btnC),
			  .Reset(btnD),
			  .Clock(Clock)
			  );

// Segments counting at 0.1 Hz.
StopWatch dut(
              .CountMax(CountMax3),
			  .Segments(Segments3),
			  .Start(btnU),
			  .Stop(btnC),
			  .Reset(btnD),
			  .Clock(Clock)
			  );

// Switching between displays.
Switching eut(
			  .Clock(Clock),
			  .Start(btnU),
			  .Stop(btnC),
			  .Segments0(Segments0),
			  .Segments1(Segments1),
			  .Segments2(Segments2),
			  .Segments3(Segments3),
			  .DisplayOut(an[3:0]),
			  .SegmentsOut(seg)
			  );

endmodule