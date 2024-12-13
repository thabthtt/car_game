module car_background (
    input wire clk,
    input wire rst,
    input wire start,
    input wire [2:0] speed_select,
    input wire [9:0] SW,
    input wire [1:0] KEY,
    input wire game_over,
    output wire hsync,
    output wire vsync, 
    output reg [23:0] rgb,
    output wire [9:0] h_count,
    output wire [9:0] v_count,
	 output reg game_active
);

// Car positions
wire [9:0] h_position;  // Car horizontal position
wire [9:0] v_position;  // Car vertical position
wire [2:0] which_car;  // Select car
wire [1:0] active_column;
// Speed control (default)
wire [19:0] speed;
assign speed = 20'h1ffff;  // Default (still quite slow)

// Traffic signals


// Traffic visibility and active flags
wire traffic_visible_1, traffic_visible_2, traffic_visible_3; 

wire spawn_traffic_1, spawn_traffic_2, spawn_traffic_3;

wire traffic_active_1, traffic_active_2, traffic_active_3;

wire traffic_active;





wire [9:0] traffic_y_position;


wire collision_1, collision_2, collision_3;




// Generate random values using LFSR (for traffic spawning)
wire [15:0] rand; 





//instantantions

lfsr lfsr_insta (
.clk(clk),
.rst(rst),
.seed(16'hACE1),
.rand(rand)
);

// VGA driver instantiation
vga_driver driver_insta (
    .clk(clk),
    .rst(rst),
    .hsync(hsync), 
    .vsync(vsync), 
    .h_count(h_count), 
    .v_count(v_count)
);

// Car position module
my_car_positions my_positions_insta(
    .clk(clk),
    .rst(rst),
    .KEY(KEY[1:0]),
    .h_position(h_position), 
    .v_position(v_position),   
    .which_car(which_car)
);

traffic_controller traffic_controller_insta(
.clk(clk),
.rst(rst), 
.start(start),
.speed(speed), 
.rand(rand), 
.active_column(active_column),
.traffic_y_position(traffic_y_position),
.traffic_active(traffic_active),
.game_over(game_over),
.collision(collision)


);






//left lane
traffic_visual traffic_visual_insta1(

.h_count(h_count),
.v_count(v_count), 
.column_start(10'd8),
.traffic_y_position(traffic_y_position), 
    .traffic_active(traffic_active && active_column == 2'b00),
    .traffic_visible(traffic_visible_1)
);


//middle lane
traffic_visual traffic_visual_insta2(
.h_count(h_count),
.v_count(v_count), 
.column_start(10'd220),
.traffic_y_position(traffic_y_position), 
    .traffic_active(traffic_active && active_column == 2'b01),
    .traffic_visible(traffic_visible_2)
);


//right lane
traffic_visual traffic_visual_insta3(
.h_count(h_count),
.v_count(v_count), 
.column_start(10'd432),
.traffic_y_position(traffic_y_position), 
    .traffic_active(traffic_active && active_column == 2'b10),
    .traffic_visible(traffic_visible_3)
);






// Collision detectors
collision_detector collision_insta_1(
    .clk(clk),
    .reset(rst),
    .car_x(h_position),
    .car_y(v_position),
    .car_width(10'd80),  // Assuming car width is 80 pixels
    .car_height(10'd80),
    .traffic_x(10'd8),  // Starting x-position of the first lane
    .traffic_y(traffic_y_position),
    .traffic_width(10'd80),  // Assuming traffic width is 80 pixels
    .traffic_height(10'd80),
    .collision(collision_1)
   
);

collision_detector collision_insta_2(
    .clk(clk),
    .reset(rst),
    .car_x(h_position),
    .car_y(v_position),
    .car_width(10'd80),
    .car_height(10'd80),
    .traffic_x(10'd220),  // Starting x-position of the second lane
    .traffic_y(traffic_y_position),
    .traffic_width(10'd80),
    .traffic_height(10'd80),
    .collision(collision_2)
);

collision_detector collision_insta_3(
    .clk(clk),
    .reset(rst),
    .car_x(h_position),
    .car_y(v_position),
    .car_width(10'd80),
    .car_height(10'd80),
    .traffic_x(10'd432),  // Starting x-position of the third lane
    .traffic_y(traffic_y_position),
    .traffic_width(10'd80),
    .traffic_height(10'd80),
    .collision(collision_3)
);


	 
	 
	 




// Main RGB logic for displaying objects on screen
always @(posedge clk or posedge rst) begin
    if (rst) begin
        rgb <= 24'h000000;  // Reset to black
    end else if ((h_count < 640) && (v_count < 480)) begin
        rgb <= 24'h000000;  // Default background color (black)

        // Draw lanes and borders
        if (traffic_visible_1) begin
            rgb <= 24'hFF0000; // Red 
        end else if (traffic_visible_2) begin
            rgb <= 24'hFF0000; // red
        end else if (traffic_visible_3) begin
            rgb <= 24'hFF0000; // red
        end 
        
        // Draw lanes
        else if (h_count < 212) begin
            rgb <= 24'hffffff; // First lane (white)
        end else if (h_count < 217) begin
            rgb <= 24'h000000; // Left border of the first lane (black)
        end else if (h_count < 424) begin
            rgb <= 24'hffffff; // Second lane (white)
        end else if (h_count < 428) begin
            rgb <= 24'h000000; // Left border of the second lane (black)
        end else if (h_count < 636) begin
            rgb <= 24'hffffff; // Third lane (white)
        end

        // Draw car in current position
        if (((h_count >= (h_position - 40)) && (h_count < (h_position + 40))) && 
            ((v_count >= v_position) && (v_count < (v_position + 80)))) begin
            
            case(which_car)
                1: rgb <= 24'h0000ff; // Red for left car
                2: rgb <= 24'h0000ff; // Green for middle car
                3: rgb <= 24'h0000ff; // Blue for right car
                default: rgb <= rgb;   // Keep previous color if no match
            endcase
        end
    end else begin
        rgb <= 24'h000000;  // Black outside display area
    end
end

endmodule


