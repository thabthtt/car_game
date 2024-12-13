module traffic_visual(
    input wire [9:0] h_count,
    input wire [9:0] v_count,
    
    input wire [9:0] column_start,
    input wire [9:0] traffic_y_position,
    input wire traffic_active,
    output reg traffic_visible

);

parameter TRAFFIC_WIDTH = 80;
parameter TRAFFIC_HEIGHT = 80;


always@(*) begin 
 traffic_visible = traffic_active && 
                         (h_count >= column_start + (TRAFFIC_WIDTH - 20)) && (h_count < column_start + (TRAFFIC_WIDTH + 60)) && 
                         (v_count >= traffic_y_position) && (v_count < traffic_y_position + TRAFFIC_HEIGHT);
								 
								 
end 

endmodule