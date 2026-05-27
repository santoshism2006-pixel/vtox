`timescale 1ns/1ps

module tb;

    reg clk;
    reg rst_n;
    reg ena;

    reg [7:0] ui_in;
    reg [7:0] uio_in;

    wire [7:0] uo_out;
    wire [7:0] uio_out;
    wire [7:0] uio_oe;

    tt_um_ecdsa_verify dut (
        .ui_in(ui_in),
        .uo_out(uo_out),
        .uio_in(uio_in),
        .uio_out(uio_out),
        .uio_oe(uio_oe),
        .ena(ena),
        .clk(clk),
        .rst_n(rst_n)
    );

    always #5 clk = ~clk;

    initial begin

        $dumpfile("wave.vcd");
        $dumpvars(0, tb);

        clk = 0;
        rst_n = 0;
        ena = 1;
        ui_in = 8'h00;
        uio_in = 8'h00;

        #10;
        rst_n = 1;

        // Correct signature
        ui_in = 8'hA5;

        #20;

        // Wrong signature
        ui_in = 8'h55;

        #20;

        $finish;

    end

endmodule
