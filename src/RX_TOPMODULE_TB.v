`timescale 1ns/1ps

module RX_TOPMODULE_TB;
    
    parameter DATAWIDTH = 8;
    reg clk;
    reg rst;
    reg serial_in;
    reg bit_enb;
    wire [DATAWIDTH-1:0] RX_DATA;
    wire RX_DONE;
    
    // Instantiate the DUT (Device Under Test)
    RX_TOPMODULE #(.DATAWIDTH(DATAWIDTH)) dut (
        .clk(clk),
        .rst(rst),
        .serial_in(serial_in),
        .bit_enb(bit_enb),
        .RX_DATA(RX_DATA),
        .RX_DONE(RX_DONE)
    );
    
    // Clock Generation
    always #5 clk = ~clk;
    
    // Test Procedure
    initial begin
        // Initialize signals
        clk = 0;
        rst = 1;
        serial_in = 0;
        bit_enb = 0;
        
        // Apply reset
        #10 rst = 0;
        
        // Simulate serial data input
        bit_enb = 1;
        #10 serial_in = 1; // Start bit
        #10 serial_in = 0; // Data bit 0
        #10 serial_in = 1; // Data bit 1
        #10 serial_in = 0; // Data bit 2
        #10 serial_in = 1; // Data bit 3
        #10 serial_in = 0; // Data bit 4
        #10 serial_in = 1; // Data bit 5
        #10 serial_in = 0; // Data bit 6
        #10 serial_in = 1; // Data bit 7
        #10 serial_in = 1; // Stop bit
        
        // Wait for RX_DONE
        wait (RX_DONE);
        
        // Display received data
        $display("Received Data: %b", RX_DATA);
        
        // End simulation
        #20 $finish;
    end
    
endmodule
