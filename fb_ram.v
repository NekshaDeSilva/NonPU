module fb_ram (
    input             clk,
    input             we,
    input      [7:0]  addr,
    input      [7:0]  din,
    output reg [7:0]  dout
);

reg [7:0] mem [0:255];

always @(posedge clk) begin
    if (we)
        mem[addr] <= din;
    dout <= mem[addr];
end

endmodule

// 2025-12-04 10:16:00

// 2025-12-08 15:07:00

// 2025-12-13 10:10:00

// 2025-12-17 14:58:00

// 2025-12-22 09:48:00

// 2025-12-26 14:17:00

// 2025-12-31 11:03:00

// 2026-01-04 16:25:00

// 2026-02-01 08:54:00

// 2026-02-02 16:00:00

// 2026-02-04 14:21:00
