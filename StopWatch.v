// Lane Schultz
// Digital Electronics Project for the following:
// This is the module for the function of a stopwatch.

`timescale 1ns/1ps

module StopWatch(
				 input       [63:0] CountMax,
				 input              Clock,
				 input				Start,
				 input              Stop,
				 input              Reset,
				 output reg  [ 6:0] Segments
				 );

// Define parameters
reg [15:0] CountSeg    = 16'd0;
reg [31:0] Count;
reg [15:0] Digit;
reg On                 = 1'b0;
reg Condition          = 1'b0;
	
// Start and stop conditions.
always @(posedge Clock)
	if      (Start)
		begin
			On                     <= 1'b1;
		end
	else if (Stop)
		begin
			On                     <= 1'b0;
		end

always @(posedge Clock)
begin
if (On)
begin
	// Do something when CounMax zero.
	if (Count == 0)
		begin
			Count                  <= CountMax;    // Reset the count.
			
			if (CountSeg == 9)                     // Defines top number to be 9.
				begin
					CountSeg       <= 0;           // Reset second timer.
				end
			else
				begin
					CountSeg       <= CountSeg+1;  // Send counter by one.
				end
		end

	// Reset counting when running.	
	else if (Reset)
		begin
			CountSeg                   <= 0;
			Count                      <= CountMax;
		end

	// Decrement the counter.
	else
		begin
			Count                  <= Count-1;
		end
end

// Reset counting when not running.
else if (Reset)
	begin
		CountSeg                   <= 0;
		Count                      <= CountMax;
	end
end
	
// Intuitive use of LED displays convention.
always @(posedge Clock)
	begin
	
		// Define which segments are used in displays.
		Digit                      <= CountSeg;
		case(Digit)
			0:        Segments = 7'b1000000;
			1:        Segments = 7'b1111001;
			2:        Segments = 7'b0100100;
			3:        Segments = 7'b0110000;
			4:        Segments = 7'b0011001;
			5:        Segments = 7'b0010010;
			6:        Segments = 7'b0000010;
			7:        Segments = 7'b1111000;
			8:        Segments = 7'b0000000;
			9:        Segments = 7'b0010000;
		endcase
	end
endmodule
