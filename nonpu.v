module nonpu (
    input clk,
    input reset
);

wire [7:0]  spike_id;
wire [15:0] voltage;

sheet u_sheet (
    .clk(clk),
    .reset(reset),
    .spike_id(spike_id),
    .v_out(voltage)
);

spike2letter u_spike2letter (
    .clk(clk),
    .reset(reset),
    .neuron_id(spike_id),
    .voltage(voltage),
    .spike(|spike_id),
    .letter()
);

endmodule

// 2025-12-06 14:45:00

// 2025-12-11 11:11:00

// 2025-12-15 16:25:00

// 2025-12-20 10:08:00

// 2025-12-24 15:54:00

// 2025-12-29 10:09:00

// 2026-01-02 15:11:00

// 2026-01-10 14:30:00

// 2026-02-02 08:48:00
