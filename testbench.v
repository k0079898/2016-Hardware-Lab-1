`timescale 1ns/1ps
module test_Mux_1bit;
  reg [2:0] count;
  wire      out;
  Mux_1bit Mux1(out, count[2], count[1], count[0]);
  initial begin
    count=3'b000;
    repeat (8) begin
      #10
      count=count+3'b001;
    end
  end
endmodule


module test_Mux_8bits;
  reg  [7:0] A, B;
  reg        Sel;
  wire [7:0] out;
  Mux_8bits Mux8(out, Sel, A, B);
  initial begin
    A=8'b11111111;
    B=8'b00000000;
    Sel=1'b0;
    repeat (2) begin
        repeat (2) begin
          #10
          A=A-8'b00000001;
          B=B+8'b00000001;
        end
      Sel=1'b1;
    end
  end
endmodule

module test_Decoder;
  reg  [3:0]   Din;
  wire [15:0] Dout;
  Decoder Dec4(Dout, Din);
  initial begin
    Din=4'b0000;
    repeat (16) begin
      #10
      Din=Din+4'b0001;
    end
  end
endmodule

module test_FullAdder;
  reg [2:0] in;
  wire      Sum, C_out;
  FullAdder FA1b(Sum, C_out, in[2], in[1], in[0]);
  initial begin
    in=3'b000;
    repeat (8) begin
      #10
      in=in+3'b001;
    end
  end
endmodule

module test_RippleCarryAdder;
  reg  [3:0] A, B;
  reg        Cin;
  wire [3:0] Sum;
  wire       Cout;
  RippleCarryAdder Rca(Sum, Cout, Cin, A, B);
  initial begin
    A=4'b0000;
    B=4'b0000;
    Cin=1'b0;
    repeat (4) begin
      repeat (2) begin
        #10
        Cin=Cin+1'b1;
      end
      B=B+4'b0001;
    end
    A=4'b1111;
    B=4'b0000;
    Cin=1'b0;
    repeat (4) begin
      repeat (2) begin
        #10
        Cin=Cin+1'b1;
      end
    B=B+4'b0001;
    end
  end
endmodule

module test_Comparator_3bits;
  reg [2:0] A, B;
  wire      lt,gt,eq;
  Comparator_3bits Com3(lt ,gt ,eq ,A ,B);
  initial begin
    A=3'b100;
    B=3'b000;
    repeat (8) begin
      #10
      B=B+3'b001;
    end
  end
endmodule

module test_Comparator_4bits;
  reg [3:0] A, B;
  wire      lt,gt,eq;
  Comparator_4bits Com4(lt ,gt ,eq ,A ,B);
  initial begin
    A=4'b1000;
    B=4'b0000;
    repeat (16) begin
      #10
      B=B+4'b0001;
    end
  end
endmodule
