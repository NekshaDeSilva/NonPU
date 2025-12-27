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

// 2025-12-04 15:41:00

// 2025-12-09 10:47:00

// 2025-12-13 16:10:00

// 2025-12-18 11:05:00

// 2025-12-22 16:09:00

// 2025-12-27 10:36:00
