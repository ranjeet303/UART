`timescale 1ns/1ps

module SIPO_REG_TB;
    parameter DATA_WIDTH = 8;
    
    reg clk;
    reg reset;
    reg serial_in;
    reg shift_en;
    wire [DATA_WIDTH-1:0] parallel_out;
    
    // Instantiate the DUT (Device Under Test)
    SIPO_REG #(.DATA_WIDTH(DATA_WIDTH)) dut (
        .clk(clk),
        .reset(reset),
        .serial_in(serial_in),
        .shift_en(shift_en),
        .parallel_out(parallel_out)
    );
    
    // Clock Generation
    always #5 clk = ~clk;
    
    // Test Procedure
    initial begin
        // Initialize signals
        clk = 0;
        reset = 1;
        serial_in = 0;
        shift_en = 0;
        
        // Apply reset
        #10 reset = 0;
        
        // Load serial data
        shift_en = 1;
        
        #10 serial_in = 1;
        #10 serial_in = 0;
        #10 serial_in = 1;
        #10 serial_in = 1;
        #10 serial_in = 0;
        #10 serial_in = 1;
        #10 serial_in = 0;
        #10 serial_in = 1;
        
        // Wait for parallel output to update
        #20;
        
        // Display results
        $display("Parallel Output: %b", parallel_out);
        
        // End simulation
        #10 $finish;
    end
    
endmodule