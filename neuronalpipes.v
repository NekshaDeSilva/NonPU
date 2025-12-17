module neuronalpipes (
    input             clk,
    input             reset,
    input      [31:0] in_data,
    output reg [31:0] out_data
);

always @(posedge clk or posedge reset) begin
    if (reset)
        out_data <= 32'd0;
    else
        out_data <= in_data;
end

endmodule

// 2025-12-08 09:55:00

// 2025-12-12 15:45:00

// 2025-12-17 10:24:00
