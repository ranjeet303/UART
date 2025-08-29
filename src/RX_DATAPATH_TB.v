`timescale 1ns/1ps

module RX_DATAPATH_TB;
    
    parameter DATAWIDTH = 8;
    reg clk;
    reg rst;
    reg serial_in;
    reg shift_en;
    reg bit_enb;
    reg ld_data;
    reg count_enb;
    wire [DATAWIDTH-1:0] RX_DATA;
    wire RX_CMP;
    wire SAMPLING_DONE;
    
    // Instantiate the DUT (Device Under Test)
    RX_DATAPATH #(.DATAWIDTH(DATAWIDTH)) dut (
        .clk(clk),
        .rst(rst),
        .serial_in(serial_in),
        .shift_en(shift_en),
        .bit_enb(bit_enb),
        .ld_data(ld_data),
        .count_enb(count_enb),
        .RX_DATA(RX_DATA),
        .RX_CMP(RX_CMP),
        .SAMPLING_DONE(SAMPLING_DONE)
    );
    
    // Clock Generation
    always #5 clk = ~clk;
    
    // Bit Enable Toggling
    always #15 bit_enb = ~bit_enb;
    
    // Test Procedure
    initial begin
        // Initialize signals
        clk = 0;
        rst = 1;
        serial_in = 0;
        shift_en = 0;
        bit_enb = 0;
        ld_data = 0;
        count_enb = 0;
        
        // Apply reset
        #10 rst = 0;
        
        // Simulate data reception
        shift_en = 1;
        count_enb = 1;
        
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
        
        // Wait for sampling to complete
        wait (SAMPLING_DONE);
        
        // Load received data
        ld_data = 1;
        #10 ld_data = 0;
        
        // Display received data
        $display("Received Data: %b", RX_DATA);
        
        // End simulation
        #20 $finish;
    end
    
endmodule
