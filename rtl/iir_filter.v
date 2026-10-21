module iir_filter (
    input  wire clk,
    input  wire rst,
    input  wire signed [3:0] x,
    output wire signed [3:0] z,
    output reg signed [3:0] y_state
    
);

    // Internal signed 4-bit filter state
    
    assign z=x;

    // Outputs of the two Baugh-Wooley multipliers
    wire signed [7:0] P1;
    wire signed [7:0] P2;

    // Numerator and rounded numerator
    wire signed [7:0] N;
    wire signed [7:0] rounded_N;
    wire signed [7:0] y_next;


    // P1 = 6*x
    baugh_wooley U1 (
        .A(x),
        .B(4'sd6),
        .P(P1)
    );

    // P2 = 2*y_previous
    baugh_wooley U2 (
        .A(y_state),
        .B(4'sd2),
        .P(P2)
    );

    // N = 6*x + 2*y_previous
    assign N = P1 + P2;

    // Round to nearest integer, with ties away from zero
    assign rounded_N = (N >= 0)
                     ? (N + 8'sd4)
                     : (N - 8'sd4);

    // Divide by 8 using signed integer division
    assign y_next = rounded_N / 8'sd8;

    // Update the filter state on the rising clock edge
    always @(posedge clk) begin
        if (rst)
            y_state <= 4'sd0;
        else
            y_state <= y_next[3:0];
    end

endmodule

