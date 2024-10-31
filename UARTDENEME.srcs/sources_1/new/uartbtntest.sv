`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Reference Book: FPGA Prototyping By Verilog Examples Xilinx Spartan-3 Version
// Authored by: Dr. Pong P. Chu
// Published by: Wiley
//
// Adapted for the Basys 3 Artix-7 FPGA by David J. Marion
//
// UART System Verification Circuit
//
// Comments:
// - Many of the variable names have been changed for clarity
//////////////////////////////////////////////////////////////////////////////////

module uart_test
#(
        parameter int DBITS = 8          // number of data bits in a word
)
(
    input logic clk_100MHz,       // basys 3 FPGA clock signal
    input logic reset,            // btnR
    input logic btn,              // btn to trigger transmission    
    input logic rx,               // USB-RS232 Rx
    output logic tx,              // USB-RS232 Tx
    output logic [3:0] an,        // 7 segment display digits
    output logic [0:6] seg,       // 7 segment display segments
    output logic [7:0] LED        // data byte display
);
    
    // Connection Signals
    logic [DBITS-1:0] rec_data;
    logic [DBITS-1:0] rx_data_out;       // from UART receiver to Rx FIFO
    logic btick;
    logic btn_debounced;  // Debounced button signal
    logic btn_debounced_reg;  // Registered version of debounced button
    logic btn_press_edge;  // Edge detection signal
    logic tx_start_reg;
    
    // Debounce module for the button
    debounce debounce_unit (
        .clk(clk_100MHz),
        .reset(reset),
        .btn_in(btn),           // Raw button input
        .btn_out(btn_debounced) // Debounced button output
    );

    // Edge detection for button press (to trigger only on rising edge)
    always_ff @(posedge clk_100MHz or posedge reset) begin
        if (reset) begin
            btn_debounced_reg <= 1'b0;
        end else begin
            btn_debounced_reg <= btn_debounced;  // Store the previous value of the debounced signal
        end
    end
    
    // Detect rising edge of the debounced button press
    assign btn_press_edge = btn_debounced && !btn_debounced_reg;

    // Receiver UART Core
    uart_top UART_UNIT (
        .clk_100MHz(clk_100MHz),
        .reset(reset),
        .rx(rx),
        .read_data(rec_data)
    );
    
    // Baud rate generator for Bluetooth UART transmission
    baud_rate_generator BT_RATE_GEN (
        .clk_100MHz(clk_100MHz), 
        .reset(reset),
        .tick(btick)
    );

    // Logic to control transmission on button press
    always_ff @(posedge clk_100MHz or posedge reset) begin
        if (reset) begin
            tx_start_reg <= 1'b0;
        end
        else if (btn_press_edge && !tx_done_tick) begin
            tx_start_reg <= 1'b1;  // Trigger transmission when button is pressed
        end 
        else begin
            tx_start_reg <= 1'b0;  // Keep low otherwise
        end
    end

    uart_transmitter BT_TX_UNIT (
        .clk_100MHz(clk_100MHz),
        .reset(reset),
        .tx_start(tx_start_reg),  // Controlled by debounced button press with edge detection
        .sample_tick(btick),
        .data_in(rec_data),
        .tx_done(tx_done_tick),
        .tx(tx)
    );
    
    fifo
    #(
         .DATA_SIZE(DBITS)
    )
    FIFO_RX_UNIT
    (
            .clk(clk_100MHz),
            .reset(reset),
	        .write_data_in(rec_data),
	        .read_data_out(rx_data_out)    
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
    logic [3:0] x_10, x_1, x_100;
    assign x_100 = (rec_data / 100) % 10;
    assign x_10 = (rec_data / 10) % 10;
    assign x_1  = rec_data % 10;

endmodule