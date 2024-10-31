`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////////////
// Reference book:
// "FPGA Prototyping by Verilog Examples"
// "Xilinx Spartan-3 Version"
// Dr. Pong P. Chu
// Wiley
//
// Adapted for Artix-7
// David J. Marion
//
// Parameterized FIFO Unit for the UART System
// 
// Comments:
// - Many of the variable names have been changed for clarity
//////////////////////////////////////////////////////////////////////////////////////////

module fifo
#(
	   parameter int DATA_SIZE = 8	       // number of bits in a data word
)
(
	   input logic clk,                              // FPGA clock           
	   input logic reset,                            // reset button
	   input logic [DATA_SIZE-1:0] write_data_in,    // data word into FIFO
	   output logic [DATA_SIZE-1:0] read_data_out    // data word out of FIFO
);

	// signal declaration
	logic [DATA_SIZE-1:0] memory;		// memory array register
	
	// register file (memory) write operation
	// FIFO control logic
	// register logic
	always_ff @(posedge clk or posedge reset) begin
		if (reset) begin
	       memory <= '0;	
	    end else begin
	       memory <= write_data_in;
		end
	end

    // Output logic
	assign read_data_out = memory;

endmodule