`timescale 1ns / 1ps
module debounce(
    input logic clk,           // Clock signal
    input logic reset,         // Reset signal
    input logic btn_in,        // Raw button input
    output logic btn_out       // Debounced button output
);

    logic [19:0] counter;      // Counter for debouncing (adjust size based on debounce duration)
    logic btn_sync_0, btn_sync_1; // Synchronize the input to avoid metastability

    // Synchronize the button input to the clock using always_ff (specific for sequential logic)
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            btn_sync_0 <= 1'b0;
            btn_sync_1 <= 1'b0;
        end else begin
            btn_sync_0 <= btn_in;
            btn_sync_1 <= btn_sync_0;
        end
    end

    // Debouncing logic using always_ff for sequential logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 20'b0;
            btn_out <= 1'b0;
        end else begin
            if (btn_sync_1 == 1'b1 && counter < 20'd1_000_000) begin
                counter <= counter + 1;  // Count up when button is pressed
            end else if (btn_sync_1 == 1'b0) begin
                counter <= 20'b0;  // Reset counter when button is released
            end

            if (counter == 20'd1_000_000) begin
                btn_out <= 1'b1;  // Button stable for debounce duration
            end else begin
                btn_out <= 1'b0;  // Button not stable yet
            end
        end
    end

endmodule