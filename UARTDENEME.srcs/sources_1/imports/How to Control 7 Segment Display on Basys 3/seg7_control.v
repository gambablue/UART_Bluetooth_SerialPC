`timescale 1ns / 1ps

module seg7_control (
    input logic clk_100MHz,
    input logic reset,
    input logic [3:0] ones,
    input logic [3:0] tens,
    input logic [3:0] hundreds,
    output logic [6:0] seg,       // segment pattern 0-9
    output logic [3:0] digit      // digit select signals
);

    // Parameters for segment patterns
    // Constant declaration
    parameter logic [6:0] ZERO  = 7'b0000001;  // 0
    parameter logic [6:0] ONE   = 7'b1001111;  // 1
    parameter logic [6:0] TWO   = 7'b0010010;  // 2 
    parameter logic [6:0] THREE = 7'b0000110;  // 3
    parameter logic [6:0] FOUR  = 7'b1001100;  // 4
    parameter logic [6:0] FIVE  = 7'b0100100;  // 5
    parameter logic [6:0] SIX   = 7'b0100000;  // 6
    parameter logic [6:0] SEVEN = 7'b0001111;  // 7
    parameter logic [6:0] EIGHT = 7'b0000000;  // 8
    parameter logic [6:0] NINE  = 7'b0000100;  // 9
    
    // To select each digit in turn
    logic [1:0] digit_select;     // 2-bit counter for selecting each of 4 digits
    logic [16:0] digit_timer;     // Counter for digit refresh
    
    // Logic for controlling digit select and digit timer
    always_ff @(posedge clk_100MHz or posedge reset) begin
        if (reset) begin
            digit_select <= 2'b00;
            digit_timer <= 17'b0;
        end else begin
            if (digit_timer == 17'd99_999) begin   // 100MHz clock = 10ns -> 100,000 cycles = 1ms
                digit_timer <= 17'b0;
                digit_select <= digit_select + 1;
            end else begin
                digit_timer <= digit_timer + 1;
            end
        end
    end
    
    // Logic for driving the 4-bit anode output based on digit select
    always_comb begin  // refresh at each 1ms
        case (digit_select)
            2'b00 : digit = 4'b1110;   // Turn on ones digit
            2'b01 : digit = 4'b1101;   // Turn on tens digit
            2'b10 : digit = 4'b1011;   // Turn on hundreds digit
            2'b11 : digit = 4'b0111;   // Turn on thousands digit (not used here)
            default: digit = 4'b1111;  // Default case for safety
        endcase
    end
    
    // Logic for driving segments based on which digit is selected and the value of each digit
    always_comb begin
        case (digit_select)
            2'b00 : begin  // ONES DIGIT
                case (ones)
                    4'b0000 : seg = ZERO;
                    4'b0001 : seg = ONE;
                    4'b0010 : seg = TWO;
                    4'b0011 : seg = THREE;
                    4'b0100 : seg = FOUR;
                    4'b0101 : seg = FIVE;
                    4'b0110 : seg = SIX;
                    4'b0111 : seg = SEVEN;
                    4'b1000 : seg = EIGHT;
                    4'b1001 : seg = NINE;
                    default: seg = ZERO;  // Default for safety
                endcase
            end
            
            2'b01 : begin  // TENS DIGIT
                case (tens)
                    4'b0000 : seg = ZERO;
                    4'b0001 : seg = ONE;
                    4'b0010 : seg = TWO;
                    4'b0011 : seg = THREE;
                    4'b0100 : seg = FOUR;
                    4'b0101 : seg = FIVE;
                    4'b0110 : seg = SIX;
                    4'b0111 : seg = SEVEN;
                    4'b1000 : seg = EIGHT;
                    4'b1001 : seg = NINE;
                    default: seg = ZERO;  // Default for safety
                endcase
            end
            
            2'b10 : begin  // HUNDREDS DIGIT
                case (hundreds)
                    4'b0000 : seg = ZERO;
                    4'b0001 : seg = ONE;
                    4'b0010 : seg = TWO;
                    4'b0011 : seg = THREE;
                    4'b0100 : seg = FOUR;
                    4'b0101 : seg = FIVE;
                    4'b0110 : seg = SIX;
                    4'b0111 : seg = SEVEN;
                    4'b1000 : seg = EIGHT;
                    4'b1001 : seg = NINE;
                    default: seg = ZERO;  // Default for safety
                endcase
            end
            
            default: seg = ZERO;  // Default case for safety
        endcase
    end

endmodule