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
