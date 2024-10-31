`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Reference Book: FPGA Prototyping By Verilog Examples Xilinx Spartan-3 Version
// Authored by: Dr. Pong P. Chu
// Published by: Wiley
//
// Adapted for the Basys 3 Artix-7 FPGA by David J. Marion
//
// UART System Verification Circuit (Continuous Transmission Version)
//
// Comments:
// - Continuous data transmission without button press.
//////////////////////////////////////////////////////////////////////////////////

module uart_test(
    input clk_100MHz,       // basys 3 FPGA clock signal
    input reset,            // btnR
    input rx,               // USB-RS232 Rx
    output tx,              // USB-RS232 Tx
    output [3:0] an,        // 7 segment display digits
    output [0:6] seg,       // 7 segment display segments
    output [7:0] LED        // data byte display
    );
    
    // Connection Signals
    wire [7:0] rec_data;
    wire btick;
    reg tx_start_reg;
    
    // Complete UART Core
    uart_top UART_UNIT (
        .clk_100MHz(clk_100MHz),
        .reset(reset),
        .rx(rx),
        .write_data(rec_data),
        .read_data(rec_data),
        .tx(tx)
    );
    
    // Baud rate generator for Bluetooth UART transmission
    baud_rate_generator BT_RATE_GEN (
        .clk_100MHz(clk_100MHz), 
        .reset(reset),
        .tick(btick)
    );

    // Logic to control continuous transmission
    always @(posedge clk_100MHz or posedge reset) begin
        if (reset) begin
            tx_start_reg <= 1'b0;
        end
        else if (!tx_done_tick) begin
            tx_start_reg <= 1'b1;  // Trigger continuous transmission
        end 
        else begin
            tx_start_reg <= 1'b0;  // Keep low during transmission completion
        end
    end

    uart_transmitter BT_TX_UNIT (
        .clk_100MHz(clk_100MHz),
        .reset(reset),
        .tx_start(tx_start_reg),  // Controlled by continuous transmission logic
        .sample_tick(btick),
        .data_in(rec_data),
        .tx_done(tx_done_tick),
        .tx(tx)
    );
    
    // 7-segment display control
    seg7_control sevensegment(
        .clk_100MHz(clk_100MHz), 
        .reset(reset), 
        .ones(x_1), 
        .tens(x_10), 
        .hundreds(x_100), 
        .seg(seg), 
        .digit(an)
    );
    
    // Display the received data on LEDs
    assign LED = rec_data;
    
    // Binary to BCD conversion for 7-segment display
    wire [3:0] x_10, x_1, x_100;
    assign x_100 = (rec_data / 100) % 10;
    assign x_10 = (rec_data / 10) % 10;
    assign x_1  = rec_data % 10;

endmodule
