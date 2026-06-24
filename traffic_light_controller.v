`timescale 1ns / 1ps

module traffic_light_controller(
    input clk,
    input reset,
    input emergency,

    output reg [2:0] highway_light,
    output reg [2:0] side_light
);

// Light Encoding
parameter RED    = 3'b100;
parameter YELLOW = 3'b010;
parameter GREEN  = 3'b001;

// FSM States
parameter HW_GREEN  = 2'b00;
parameter HW_YELLOW = 2'b01;
parameter SIDE_GREEN = 2'b10;
parameter SIDE_YELLOW = 2'b11;

reg [1:0] state;
reg [31:0] timer;

// Timing values (simulation-friendly)
parameter GREEN_TIME  = 10;
parameter YELLOW_TIME = 3;

always @(posedge clk or posedge reset)
begin
    if(reset)
    begin
        state <= HW_GREEN;
        timer <= 0;
    end
    else
    begin

        // Emergency Vehicle Priority
        if(emergency)
        begin
            state <= HW_GREEN;
            timer <= 0;
        end
        else
        begin
            timer <= timer + 1;

            case(state)

                HW_GREEN:
                begin
                    if(timer >= GREEN_TIME)
                    begin
                        state <= HW_YELLOW;
                        timer <= 0;
                    end
                end

                HW_YELLOW:
                begin
                    if(timer >= YELLOW_TIME)
                    begin
                        state <= SIDE_GREEN;
                        timer <= 0;
                    end
                end

                SIDE_GREEN:
                begin
                    if(timer >= GREEN_TIME)
                    begin
                        state <= SIDE_YELLOW;
                        timer <= 0;
                    end
                end

                SIDE_YELLOW:
                begin
                    if(timer >= YELLOW_TIME)
                    begin
                        state <= HW_GREEN;
                        timer <= 0;
                    end
                end

            endcase
        end
    end
end

// Output Logic
always @(*)
begin
    case(state)

        HW_GREEN:
        begin
            highway_light = GREEN;
            side_light    = RED;
        end

        HW_YELLOW:
        begin
            highway_light = YELLOW;
            side_light    = RED;
        end

        SIDE_GREEN:
        begin
            highway_light = RED;
            side_light    = GREEN;
        end

        SIDE_YELLOW:
        begin
            highway_light = RED;
            side_light    = YELLOW;
        end

        default:
        begin
            highway_light = RED;
            side_light    = RED;
        end

    endcase
end

endmodule
