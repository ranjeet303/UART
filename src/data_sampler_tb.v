`timescale 1ns/1ps

module data_sampler_tb;
    parameter PWIDTH = 6;
    
    reg clk, rst;
    reg [PWIDTH-1:0] prescale, edge_counter;
    reg data_sampling_en;
    reg rx_in;
    wire sampled_bit;

    // Instantiate the data_sampler module
    data_sampler #(.PWIDTH(PWIDTH)) uut (
        .clk(clk),
        .rst(rst),
        .prescale(prescale),
        .edge_counter(edge_counter),
        .data_sampling_en(data_sampling_en),
        .rx_in(rx_in),
        .sampled_bit(sampled_bit)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 100MHz clock
    end

    // Stimulus
    initial begin
        rst = 0;
        prescale = 6'd16;
        edge_counter = 6'd0;
        data_sampling_en = 0;
        rx_in = 1;
        #20;
        
        rst = 1;
        data_sampling_en = 1;
        
        // Simulate a sampling process with alternating rx_in values
        repeat (10) begin
            #10 edge_counter = edge_counter + 1;
            rx_in = ~rx_in;
        end
        
        #50;
        $finish;
    end

    // Monitor outputs
    initial begin
        $monitor($time, " sampled_bit=%b, ones=%d, zeros=%d", sampled_bit, uut.ones, uut.zeros);
    end

endmodule
