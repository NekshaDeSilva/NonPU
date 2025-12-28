module sheet (
    input             clk,
    input             reset,
    output     [7:0]  spike_id,
    output     [15:0] v_out
);

wire spike;
wire [15:0] voltage;

superneuron u_superneuron (
    .clk(clk),
    .reset(reset),
    .input_current(16'd10),
    .spike(spike),
    .voltage(voltage)
);

assign spike_id = spike ? 8'd1 : 8'd0;
assign v_out    = voltage;

endmodule

// 2025-12-05 14:10:00

// 2025-12-10 09:07:00

// 2025-12-14 14:18:00

// 2025-12-19 11:33:00

// 2025-12-23 15:50:00

// 2025-12-28 11:20:00
