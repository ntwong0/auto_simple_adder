`timescale 1ns / 1ps

module tb_simple_adder();
    reg  signed [3:0] a, b;
    wire signed [3:0] y;
    wire overflow;
    simple_adder dut(.input_a(a),.input_b(b),.output_y(y), .overflow(overflow));
    
    integer i;
    integer j;
    integer signed_i;
    integer signed_j;
    integer error_count=0;
    initial begin
        {a, b} = 0;
        for (i = 0; i < 'hf; i = i + 1)
        begin
        for(j = 0; j < 'hf; j = j + 1)
        begin
            #1 
                a = i; b = j;
                signed_i = (i > 7) ? (('hfffffff0 | i)) : i;
                signed_j = (j > 7) ? (('hfffffff0 | j)) : j;
            #1 
                if (y != signed_i + signed_j) 
                begin 
                    $display("anomaly: y != a + b: %d != %d + %d vs. %d != %d + %d", y, a, b, signed_i + signed_j, signed_i, signed_j); 
                    if(!overflow) error_count = error_count+1; 
                end
        end
        end
        #1
        $display("error count: %d", error_count);
        $finish;
    end
    
endmodule

