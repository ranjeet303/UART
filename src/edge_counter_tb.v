`timescale 1ns/1ps

module edge_counter_tb;
    parameter PWIDTH = 6;
    
    reg clk, rst, enable;
    reg [PWIDTH-1:0] prescale;
    wire [PWIDTH-2:0] bit_counter;
    wire [PWIDTH-1:0] edge_counter;

    // Instantiate the edge_counter module
    edge_counter #(.PWIDTH(PWIDTH)) uut (
        .clk(clk),
        .rst(rst),
        .enable(enable),
        .prescale(prescale),
        .bit_counter(bit_counter),
        .edge_counter(edge_counter)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 100MHz clock
    end

    // Stimulus
    initial begin
        rst = 0;
        enable = 0;
        prescale = 6'd8;
        #20;
        
        rst = 1;
        enable = 1;
        
        // Simulate counting process
        repeat (20) begin
            #10;
        end
        
        #50;
        $finish;
    end

    // Monitor outputs
    initial begin
        $monitor($time, " edge_counter=%d, bit_counter=%d", edge_counter, bit_counter);
    end

endmodule