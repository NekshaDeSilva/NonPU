// top_nonpu.v
// Minimal synthesizable top-level for NonPU v0.1

module nonpu (
    input  wire clk,       // connect to board 50 MHz clock later
    input  wire reset_n    // active-low reset from a button or pin
);

    // Active-high reset inside the design
    wire reset = ~reset_n;

    // Wires between modules
    wire        frame_tick;
    wire        spike_valid;
    wire [15:0] spike_idx;
    wire signed [31:0] v_debug;
    wire [3:0]  tile_id;

    wire [3:0]  overactive_tile_id;
    wire [3:0]  underactive_tile_id;
    wire [7:0]  avg_spike_count;
    wire [15:0] bias_out;

    wire        fb_we;
    wire [7:0]  fb_addr;
    wire [7:0]  fb_data;

    // ==========================
    // Time-multiplexed neuron sheet
    // ==========================
    sheet #(
        .GRID_W(16),
        .GRID_H(16)
    ) sheet_inst (
        .clk         (clk),
        .reset       (reset),
        .frame_tick  (frame_tick),
        .spike_valid (spike_valid),
        .spike_idx   (spike_idx),
        .v_debug     (v_debug),
        .tile_id_out (tile_id),
        .bias_in     (bias_out)
    );

    // ==========================
    // Activity monitor (per-tile firing statistics)
    // ==========================
    activitymonitor #(
        .GRID_W(16),
        .GRID_H(16)
    ) activitymonitor_inst (
        .clk               (clk),
        .reset             (reset),
        .spike_valid       (spike_valid),
        .spike_idx         (spike_idx),
        .frame_tick        (frame_tick),
        .overactive_tile_id(overactive_tile_id),
        .underactive_tile_id(underactive_tile_id),
        .avg_spike_count   (avg_spike_count)
    );

    // ==========================
    // Superneuron (global / tile-level bias modulation)
    // ==========================
    superneuron #(
        .GRID_W(16),
        .GRID_H(16)
    ) superneuron_inst (
        .clk               (clk),
        .reset             (reset),
        .frame_tick        (frame_tick),
        .overactive_tile_id(overactive_tile_id),
        .underactive_tile_id(underactive_tile_id),
        .avg_spike_count   (avg_spike_count),
        .tile_id_query     (tile_id),
        .bias_out          (bias_out)
    );

    // ==========================
    // Framebuffer RAM (256 pixels, 8-bit grayscale)
    // ==========================
    fb_ram #(
        .ADDR_WIDTH(8),   // 2^8 = 256 neurons / pixels
        .DATA_WIDTH(8)
    ) fb_ram_inst (
        .clk    (clk),
        .we     (fb_we),
        .addr_a (fb_addr),
        .data_a (fb_data),
        .addr_b (8'd0),   // not used yet (read port left idle)
        .q_b    ()
    );

    // ==========================
    // Spike-to-pixel converter
    // ==========================
    spike2letter #(
        .NEURON_ADDR_WIDTH(8),  // indices 0..255
        .WIDTH(32)              // matches v_debug width
    ) spike2letter_inst (
        .clk       (clk),
        .rst       (reset),
        .spike_valid(spike_valid),
        .spike_idx (spike_idx[7:0]),  // use lower 8 bits for 256 neurons
        .v_in      (v_debug),
        .fb_we     (fb_we),
        .fb_addr   (fb_addr),
        .fb_data   (fb_data)
    );

endmodule

// 2025-12-07 09:23:00

// 2025-12-11 14:36:00
