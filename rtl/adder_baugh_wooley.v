module adder(
output S,
output C,
input a,
input b,
input c
    );
    assign S = a^b^c;
    assign C = (a&b)|(b&c)|(c&a);
    
endmodule
