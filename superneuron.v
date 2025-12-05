module superneuron (
    input             clk,
    input             reset,
    input      [15:0] input_current,
    output reg        spike,
    output reg [15:0] voltage
);

reg [15:0] global_gain;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        voltage     <= 16'd0;
        spike       <= 1'b0;
        global_gain <= 16'd1;
    end else begin
        voltage <= voltage + input_current * global_gain;
        spike   <= (voltage > 16'd1000);
    end
end

endmodule

// 2025-12-05 11:06:00
