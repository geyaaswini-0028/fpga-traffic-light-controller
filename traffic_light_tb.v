`timescale 1ns / 1ps

module traffic_light_tb;

reg clk;
reg reset;
reg emergency;

wire [2:0] highway_light;
wire [2:0] side_light;

traffic_light_controller uut(
    .clk(clk),
    .reset(reset),
    .emergency(emergency),
    .highway_light(highway_light),
    .side_light(side_light)
);

// Clock Generation
always #5 clk = ~clk;

initial
begin
    clk = 0;
    reset = 1;
    emergency = 0;

    #20;
    reset = 0;

    // Run normal operation
    #300;

    // Emergency vehicle detected
    emergency = 1;
    #50;

    emergency = 0;

    #300;

    $finish;
end

initial
begin
    $monitor("Time=%0t | Emergency=%b | Highway=%b | Side=%b",
              $time, emergency, highway_light, side_light);
end

endmodule
