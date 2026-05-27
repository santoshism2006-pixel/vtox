`default_nettype none
`timescale 1ns / 1ps

/*
 * Testbench for Firmware Signature Verification Accelerator
 * Tiny Tapeout Project
 */

module tb ();

  // Dump waveform signals to FST file
  initial begin
    $dumpfile("tb.fst");
    $dumpvars(0, tb);
    #1;
  end

  // Clock and reset
  reg clk;
  reg rst_n;
  reg ena;

  // Inputs
  reg [7:0] ui_in;
  reg [7:0] uio_in;

  // Outputs
  wire [7:0] uo_out;
  wire [7:0] uio_out;
  wire [7:0] uio_oe;

`ifdef GL_TEST
  wire VPWR = 1'b1;
  wire VGND = 1'b0;
`endif

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // DUT Instantiation
  tt_um_fw_signature_verify user_project (

`ifdef GL_TEST
      .VPWR(VPWR),
      .VGND(VGND),
`endif

      .ui_in   (ui_in),     // Dedicated inputs
      .uo_out  (uo_out),    // Dedicated outputs
      .uio_in  (uio_in),    // IO input path
      .uio_out (uio_out),   // IO output path
      .uio_oe  (uio_oe),    // IO enable path
      .ena     (ena),       // Enable signal
      .clk     (clk),       // Clock
      .rst_n   (rst_n)      // Active-low reset
  );

  // Test sequence
  initial begin

    // Initialize signals
    ena    = 1'b1;
    rst_n  = 1'b0;
    ui_in  = 8'b00000000;
    uio_in = 8'b00000000;

    // Apply reset
    #20;
    rst_n = 1'b1;

    // Test Case 1: Valid firmware signature
    #10;
    ui_in  = 8'hAA;
    uio_in = 8'hAA;

    // Test Case 2: Invalid firmware signature
    #20;
    ui_in  = 8'h55;
    uio_in = 8'h0F;

    // Test Case 3: Another valid firmware signature
    #20;
    ui_in  = 8'hF0;
    uio_in = 8'hF0;

    // Finish simulation
    #50;
    $finish;
  end

endmodule
