module traffic_controller (
    input clk, 
    input rst, 
    input start,
    input wire [19:0] speed,
    input wire [15:0] rand, 
    output reg [1:0] active_column,
    output reg [9:0] traffic_y_position,
    output reg traffic_active,
    output reg game_over,
    input wire collision,  // This is the collision signal from the car module
    input wire [9:0] SW  // Added SW as an input
);

parameter SPAWN_THRESHOLD = 16'h8000; // Threshold for spawning traffic
reg [19:0] counter;  // Counter for controlling timing
reg sw_9_state;  // State for SW[9] behavior (used for toggling or reset)

// Handle traffic control logic
always @(posedge clk or posedge rst) begin
    if (rst) begin
        // Reset all variables on reset
        counter <= 0;
        active_column <= 2'b00;
        traffic_active <= 0;
        traffic_y_position <= 0;
        game_over <= 0;
        sw_9_state <= 1;  // Initialize SW state
    end else if (start && !game_over) begin
        // Handle counter for controlling speed
        if (counter >= speed) begin
            counter <= 0; // Reset counter after each cycle

            // Check for collision before moving the traffic
            if (collision) begin
                // If collision occurs, set game over
                game_over <= 1; 
				end

                // Handle SW[9] logic for toggling state on collision
                
             else begin
                // If traffic is active, move it downward
                if (traffic_active) begin
                    // Move traffic downward
                    if (traffic_y_position < 480) begin 
                        traffic_y_position <= traffic_y_position + 1;
                    end else begin
                        // If traffic reaches the bottom, reset traffic
                        traffic_active <= 0;
                        traffic_y_position <= 0;
                    end
                end

                // Spawn new traffic only if there is no active traffic and random value exceeds threshold
                if (!traffic_active && rand > SPAWN_THRESHOLD) begin
                    traffic_active <= 1;
                    active_column <= rand[1:0];  // Randomly select column for the traffic
                end
            end
        end else begin
            // Increment counter to control timing
            counter <= counter + 1;
        end
    end // end of start && !game_over condition
 // end of always block
end
endmodule
