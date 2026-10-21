module tb_iir;

    reg clk;
    reg rst;
    reg signed [3:0] x;

    wire signed [3:0] z;
    wire signed [3:0] y_state;

    iir_filter uut (
        .clk(clk),
        .rst(rst),
        .x(x),
        .z(z),
        .y_state(y_state)
    );

    // Generate a clock with a 10 ns period
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        $monitor("Time=%0t | rst=%b | x=%0d | y_state=%0d | y_binary=%b",
                 $time, rst, x, y_state, y_state);

        // Reset the filter
        rst = 1;
        x = 0;
        #20;

        rst = 0;

        // Apply input samples
        x = 4;
        #40;

        x = 2;
        #40;

        x = 0;
        #40;

        x = -2;
        #40;

        $finish;
    end

endmodule

