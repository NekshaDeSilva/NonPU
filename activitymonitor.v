module activitymonitor (
    input             clk,
    input             reset,
    input      [15:0] activity,
    output reg [7:0]  level
);

always @(posedge clk or posedge reset) begin
    if (reset)
        level <= 8'd0;
    else
        level <= activity[15:8];
end

endmodule
