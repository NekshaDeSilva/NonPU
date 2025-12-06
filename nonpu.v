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
