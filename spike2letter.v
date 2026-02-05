module spike2letter (
    input              clk,
    input              reset,
    input      [7:0]   neuron_id,
    input      [15:0]  voltage,
    input              spike,
    output reg [7:0]   letter
);

always @(posedge clk or posedge reset) begin
    if (reset)
        letter <= 8'd0;
    else if (spike)
        letter <= neuron_id;
end

endmodule

// 2025-12-06 09:55:00

// 2025-12-10 15:14:00

// 2025-12-15 09:05:00

// 2025-12-19 14:43:00

// 2025-12-24 11:32:00

// 2025-12-28 15:46:00

// 2026-01-02 11:18:00

// 2026-01-06 15:51:00

// 2026-02-01 16:56:00

// 2026-02-03 14:20:00

// 2026-02-05 12:57:00
