`timescale 1ns / 1ps

module tb_neuronalpipes;

    localparam integer WIDTH  = 32;
    localparam integer FRAC = 16;

    reg clk;
    reg rst;
    reg  en;
    reg signed [WIDTH-1:0] v_in;
    reg signed [WIDTH-1:0]  u_in;
    reg signed [WIDTH-1:0] I_in;
    wire signed [WIDTH-1:0]  v_out;
    wire signed [WIDTH-1:0] u_out;
    wire spike_out;

    neuronalpipes #(
        .WIDTH(WIDTH),
        .FRAC(FRAC)
    ) dut (
        .clk(clk),
        .rst(rst),
        .en(en),
        .v_in(v_in),
        .u_in(u_in),
        .I_in(I_in),
        .v_out(v_out),
        .u_out(u_out),
        .spike_out(spike_out)
    );

    initial begin
        clk = 0;
        forever #5 clk =  ~clk;
    end

    function signed [WIDTH-1:0] to_fixed;
        input real r;
        begin
            to_fixed = $rtoi(r *  (1<<FRAC));
        end
    endfunction

    integer step_count;

    initial begin
        $dumpfile("tb_neuronalpipes.vcd");
        $dumpvars(0, tb_neuronalpipes);

        rst = 1;
        en =  0;
        v_in = to_fixed(-65.0);
        u_in = 0;
        I_in =  0;
        step_count = 0;

        repeat (5) @(posedge clk);
        rst =  0;

        en = 1;

        repeat (5) @(posedge clk);
        I_in = to_fixed(10.0);

        for (step_count = 0; step_count < 200; step_count = step_count+1) begin
            @(posedge clk);

            v_in <=  v_out;
            u_in <= u_out;

            if (step_count % 10 == 0) begin
                $display("t=%0d ms, v=%0d, u=%0d, spike=%0b",
                         step_count,
                         v_out,
                         u_out,
                         spike_out);
            end
        end

        $display("Simulation finished.");
        $finish;
    end

endmodule
