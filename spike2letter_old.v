`timescale 1ns / 1ps

module spike2letter #(
    parameter integer WIDTH = 32,
    parameter integer FRAC  = 16,
    parameter integer NEURON_ADDR_WIDTH = 8
)(
    input wire clk,
    input wire  rst,

    input wire spike_valid,
    input wire [NEURON_ADDR_WIDTH-1:0]  neuron_idx,
    input wire signed [WIDTH-1:0] v_in,

    output reg fb_we,
    output reg [NEURON_ADDR_WIDTH-1:0]  fb_addr,
    output reg [7:0] fb_data
);

    wire signed [WIDTH-1:0] v_shifted = v_in >>>  (FRAC - 4);
    wire signed [8:0] v_bias = v_shifted[7:0] + 9'sd128;

    wire [7:0] v_gray =
        (v_bias < 0) ?  8'd0 :
        (v_bias > 255) ? 8'd255 :
                         v_bias[7:0];

    always @(posedge clk) begin
        if (rst) begin
            fb_we <=  1'b0;
            fb_addr <= {NEURON_ADDR_WIDTH{1'b0}};
            fb_data <= 8'd0;
        end else begin
            fb_we <= 1'b1;
            fb_addr <=  neuron_idx;

            if (spike_valid)
                fb_data <= 8'd255;
            else
                fb_data <=  v_gray;
        end
    end

endmodule
