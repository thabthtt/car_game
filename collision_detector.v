module collision_detector (
    input wire clk,
    input wire reset,
    input wire [9:0] car_x,
    input wire [9:0] car_y,
    input wire [9:0] car_width,
    input wire [9:0] car_height,
    input wire [9:0] traffic_x,
    input wire [9:0] traffic_y,
    input wire [9:0] traffic_width,
    input wire [9:0] traffic_height,
    output reg collision
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            collision <= 0; // Reset collision status
        end else begin
            // Check for collision
            if ((car_x < traffic_x + traffic_width) && 
                (car_x + car_width > traffic_x) && 
                (car_y < traffic_y + traffic_height) && 
                (car_y + car_height > traffic_y)) begin
                collision <= 1; // Set collision if detected
            end else begin 
                collision <= 0; // No collision
            end
        end
    end

endmodule
