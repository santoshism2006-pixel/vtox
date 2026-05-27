`default_nettype none

module tt_um_fw_signature_verify (
    input  wire [7:0] ui_in,
    output wire [7:0] uo_out,
    input  wire [7:0] uio_in,
    output wire [7:0] uio_out,
    output wire [7:0] uio_oe,
    input  wire       ena,
    input  wire       clk,
    input  wire       rst_n
);

    // Simple signature verification logic
    // Output becomes 1 when input matches pattern

    wire signature_valid;

    assign signature_valid = (ui_in == 8'hA5);

    assign uo_out = signature_valid ? 8'hFF : 8'h00;

    // Bidirectional IO disabled
    assign uio_out = 8'b00000000;
    assign uio_oe  = 8'b00000000;

endmodule

`default_nettype wire
