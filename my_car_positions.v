module my_car_positions (
    input clk, 
    input rst,
    input [1:0] KEY,
    output reg [9:0] h_position,
    output reg [9:0] v_position,
    output reg [2:0] which_car
); 

reg [2:0] S; // Current state
reg [2:0] NS; // Next state
reg [1:0] prev_KEY; // To store the previous state of keys
// State definitions
parameter START = 3'b000;
parameter MIDDLE = 3'b001;
parameter RIGHT = 3'b010;
parameter LEFT = 3'b011; 
parameter DEFAULT = 3'b100;




wire right_key_pressed = (~KEY[0] & prev_KEY[0]); // Rising edge detection for KEY[0] (Right key)
wire left_key_pressed = (~KEY[1] & prev_KEY[1]);  // Rising edge detection for KEY[1] (Left key)
wire right_key_released = (KEY[0] & ~prev_KEY[0]); // Falling edge detection for KEY[0] (Right key)
wire left_key_released = (KEY[1] & ~prev_KEY[1]);  // Falling edge detection for KEY[1] (Left key)






// State transition logic
always @(posedge clk or posedge rst) begin
    if (rst) 
        S <= START;
    else 
        S <= NS; 
end 

// Next state logic
always @(*) begin
    case(S) 
        START: NS = MIDDLE; 
        MIDDLE: begin
            if (right_key_pressed) // Right key pressed (active low), move to RIGHT
                NS = RIGHT; 
            else if (left_key_pressed) // Left key pressed (active low), move to LEFT
                NS = LEFT;
            else
                NS = MIDDLE; // Stay in MIDDLE if no key is pressed
        end
        RIGHT: begin
            if (left_key_pressed) // Left key pressed, move to MIDDLE
                NS = MIDDLE;
            else if (right_key_released) // Right key released, stay in RIGHT
                NS = RIGHT;
            else
                NS = RIGHT; // Stay in RIGHT state if no transition is needed
        end
        LEFT: begin
            if (right_key_pressed) // Right key pressed, move to MIDDLE
                NS = MIDDLE;
            else if (left_key_released) // Left key released, stay in LEFT
                NS = LEFT;
            else
                NS = LEFT; // Stay in LEFT state if no transition is needed
        end
        DEFAULT: NS = MIDDLE; // Default transition on error
    endcase
end









// Output logic for positions and which car indicator
always @(posedge clk or posedge rst) begin 
    if (rst) begin 
        h_position <= 320; 
        v_position <= 395; // Set initial vertical position
        which_car <= 2; // Default to middle car on reset
    end else begin 
        case(NS) 
            MIDDLE: begin 
                h_position <= 320; 
                which_car <= 2; // Middle car identifier
            end
            LEFT: begin
                h_position <= 104;
                which_car <= 1; // Left car identifier
            end
            RIGHT: begin 
                h_position <= 532; 
                which_car <= 3; // Right car identifier
            end
            DEFAULT: begin 
                h_position <= 320; // Default to middle on error or unknown state
                which_car <= 2; // Default to middle car identifier on error or unknown state
            end
        endcase

        // Vertical position remains constant, but you can modify it here if needed.
    end
end

always @(posedge clk or posedge rst) begin
    if (rst) 
        prev_KEY <= 2'b11;  // Set to '11' for no keys pressed initially
    else
        prev_KEY <= KEY;
end

endmodule