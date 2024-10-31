`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Reference Book: FPGA Prototyping By Verilog Examples Xilinx Spartan-3 Version
// Authored by: Dr. Pong P. Chu
// Published by: Wiley
//
// Adapted for the Basys 3 Artix-7 FPGA by David J. Marion
//
// Top Module for the Complete UART System
//
// Setup for 9600 Baud Rate
//
// For 9600 baud with 100MHz FPGA clock: 
// 9600 * 16 = 153,600
// 100 * 10^6 / 153,600 = ~651      (counter limit M)
// log2(651) = 10                   (counter bits N) 
//
// For 19,200 baud rate with a 100MHz FPGA clock signal:
// 19,200 * 16 = 307,200
// 100 * 10^6 / 307,200 = ~326      (counter limit M)
// log2(326) = 9                    (counter bits N)
//
// For 115,200 baud with 100MHz FPGA clock:
// 115,200 * 16 = 1,843,200
// 100 * 10^6 / 1,843,200 = ~52     (counter limit M)
// log2(52) = 6                     (counter bits N) 
//
// For 1500 baud with 100MHz FPGA clock:
// 1500 * 16 = 24,000
// 100 * 10^6 / 24,000 = ~4,167     (counter limit M)
// log2(4167) = 13                  (counter bits N) 
//
// Comments:
// - Many of the variable names have been changed for clarity
//////////////////////////////////////////////////////////////////////////////////

module uart_top
    #(
        parameter int DBITS = 8,          // number of data bits in a word
                   int SB_TICK = 16,      // number of stop bit / oversampling ticks
                   int BR_LIMIT = 651,    // baud rate generator counter limit
                   int BT_LIMIT = 54,
                   int BR_BITS = 10,      // number of baud rate generator counter bits
                   int FIFO_EXP = 2       // exponent for number of FIFO addresses (2^2 = 4)
    )
    (
        input logic clk_100MHz,               // FPGA clock
        input logic reset,                    // reset
        input logic rx,                       // serial data in
        output logic [DBITS-1:0] read_data    // data to Rx FIFO
    );
    
    // Connection Signals
    logic tick;                          // sample tick from baud rate generator
    logic rx_done_tick;                  // data word received
   // logic [DBITS-1:0] tx_fifo_out;       from Tx FIFO to UART transmitter
    logic [DBITS-1:0] rx_data_out;       // from UART receiver to Rx FIFO
    
    // Instantiate Modules for UART Core
    baud_rate_generator 
        #(
            .M(BR_LIMIT), 
            .N(BR_BITS)
         ) 
        BAUD_RATE_GEN   
        (
            .clk_100MHz(clk_100MHz), 
            .reset(reset),
            .tick(tick)
         );
    
         
    uart_receiver
        #(
            .DBITS(DBITS),
            .SB_TICK(SB_TICK)
         )
         UART_RX_UNIT
         (
            .clk_100MHz(clk_100MHz),
            .reset(reset),
            .rx(rx),
            .sample_tick(tick),
            .data_ready(rx_done_tick),
            .data_out(read_data)
         );
    
 endmodule