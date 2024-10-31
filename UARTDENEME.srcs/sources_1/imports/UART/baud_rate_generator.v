`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Reference Book: FPGA Prototyping By Verilog Examples Xilinx Spartan-3 Version
// Authored by: Dr. Pong P. Chu
// Published by: Wiley
//
// Adapted for the Basys 3 Artix-7 FPGA by David J. Marion
//
// Baud Rate Generator for the UART System
//
// Comments:
// - Many of the variable names have been changed for clarity
//////////////////////////////////////////////////////////////////////////////////

module baud_rate_generator
    #(
        parameter int N = 10,     // number of counter bits
        parameter int M = 651     // counter limit value
    )
    (
        input  logic clk_100MHz,  // basys 3 clock
        input  logic reset,       // reset
        output logic tick         // sample tick
    );
    
    // Counter Register
    logic [N-1:0] counter;        // counter value
    logic [N-1:0] next;           // next counter value
    
    // Register Logic
    always_ff @(posedge clk_100MHz or posedge reset) begin
        if (reset)
            counter <= '0;
        else
            counter <= next;
    end

    // Next Counter Value Logic
    assign next = (counter == (M-1)) ? '0 : counter + 1;
    
    // Output Logic
    assign tick = (counter == (M-1)) ? 1'b1 : 1'b0;
       
endmodule