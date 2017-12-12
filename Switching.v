// Lane Schultz
// Digital Electronics Project for the following:
// This is the module for switching between LED displays.

`timescale 1ns/1ps

module Switching (
				  input Clock,
				  input Start,
				  input Stop,
				  input [6:0] Segments0,
				  input [6:0] Segments1,
				  input [6:0] Segments2,
				  input [6:0] Segments3,
				  output reg [3:0] DisplayOut,
				  output reg [6:0] SegmentsOut				
				  );

parameter CountMax0 = 32'd10000;
parameter CountMax1 = 32'd20000;
parameter CountMax2 = 32'd30000;
parameter CountMax3 = 32'd40000;

reg [ 3:0] DisplayOut;
reg [31:0] Count0;
reg [31:0] Count1;
reg [31:0] Count2;
reg [31:0] Count3;

always @(posedge Clock)
begin
if      (Count0 == CountMax0)
	begin
		DisplayOut  <= 4'b1110;    // Switch to Display 0.
		SegmentsOut <= Segments0;
		Count0      <= 32'b0;      // Reset the counter.
	end
else if (Count1 == CountMax1)
	begin
		DisplayOut  <= 4'b1101;    // Switch to Display 1.
		SegmentsOut <= Segments1;
		Count1      <= 32'b0;      // Reset the counter.
	end
else if (Count2 == CountMax2)
	begin
		DisplayOut  <= 4'b1011;    // Switch to Display 2.
		SegmentsOut <= Segments2;
		Count2      <= 32'b0;      // Reset the counter.
	end
else if (Count3 == CountMax3)
	begin
		DisplayOut  <= 4'b0111;    // Switch to Display 3.
		SegmentsOut <= Segments3;
		Count3      <= 32'b0;      // Reset the counter.
	end
else
	begin
		Count0      <= Count0+1;   // Increment the counter.
		Count1      <= Count1+1;   // Increment the counter.
		Count2      <= Count2+1;   // Increment the counter.
		Count3      <= Count3+1;   // Increment the counter.
	end
end
				
endmodule