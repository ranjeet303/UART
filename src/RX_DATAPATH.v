`timescale 1ns/1ps

module RX_DATAPATH #(
    parameter DATAWIDTH = 8
)(
    input wire clk,
    input wire rst,
    input wire serial_in,
    input wire shift_en,
    input wire bit_enb,
    input wire ld_data,
    input wire count_enb, 
    output wire [DATAWIDTH-1:0] RX_DATA,
    output wire RX_CMP,
    output wire SAMPLING_DONE
);

    wire [DATAWIDTH-1:0] parallel_out;
    
    // Instantiate SIPO Register
    SIPO_REG #(.DATA_WIDTH(DATAWIDTH)) sipo_inst (
        .clk(clk),
        .reset(rst),
        .serial_in(serial_in),
        .shift_en(shift_en),
        .parallel_out(parallel_out)
    );
    
    // Instantiate BIT Counter
    BIT_COUNTER bit_counter_inst (
        .clk(clk),
        .rst(rst),
        .bit_enb(bit_enb),
        .RX_CMP(RX_CMP)
    );
    
    // Instantiate SAMPLE Counter with count enable
    sample_counter sample_counter_inst (
        .clk(clk),
        .reset(rst),
        .count_enb(count_enb), // Connected count enable signal
        .SAMPLING_DONE(SAMPLING_DONE)
    );
    
    // Instantiate Output Register
    Reg_out #(.DATA_WIDTH(DATAWIDTH)) reg_out_inst (
        .clk(clk),
        .rst(rst),
        .Parallel_in(parallel_out),
        .ld_data(ld_data),
        .RX_DATA(RX_DATA)
    );
    
endmodule
