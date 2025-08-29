`timescale 1ns/1ps

module RX_TOPMODULE #(
    parameter DATAWIDTH = 8
)(
    input wire clk,
    input wire rst,
    input wire serial_in,
    input bit_enb,
    output wire [DATAWIDTH-1:0] RX_DATA,
    output wire RX_DONE
);

    wire shift_en, count_enb, ld_data, RX_CMP, SAMPLING_DONE;

    // Instantiate Receiver Controller
    RX_CONTROLLER rx_ctrl (
        .clk(clk),
        .rst(rst),
        .RX_CMP(RX_CMP),
        .SAMPLING_DONE(SAMPLING_DONE),
        .shift_en(shift_en),
        .count_enb(count_enb),
        .ld_data(ld_data),
        .RX_DONE(RX_DONE)
    );

    // Instantiate Datapath
    RX_DATAPATH #(.DATAWIDTH(DATAWIDTH)) RX_dp (
        .clk(clk),
        .rst(rst),
        .serial_in(serial_in),
        .shift_en(shift_en),
        .bit_enb(bit_enb), // Assuming bit enable is always high
        .ld_data(ld_data),
        .count_enb(count_enb),
        .RX_DATA(RX_DATA),
        .RX_CMP(RX_CMP),
        .SAMPLING_DONE(SAMPLING_DONE)
    );

endmodule
