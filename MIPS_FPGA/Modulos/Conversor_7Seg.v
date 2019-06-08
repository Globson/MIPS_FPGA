module Conversor_7Seg (entrada,saida1,saida2);
  input [31:0]entrada;
  output [6:0] saida1,saida2;

  wire [31:0] Aux1 = entrada /10;
  wire [31:0] Aux2 = entrada %10;

  assign saida1 = (Aux1 == 32'd0) ? 7'b1000000:
               (Aux1 == 32'd1) ? 7'b1001111:
               (Aux1 == 32'd2) ? 7'b0100100:
               (Aux1 == 32'd3) ? 7'b0110000:
               (Aux1 == 32'd4) ? 7'b0011001:
               (Aux1 == 32'd5) ? 7'b0010010:
               (Aux1 == 32'd6) ? 7'b0000010:
               (Aux1 == 32'd7) ? 7'b1111000:
               (Aux1 == 32'd8) ? 7'b0000000:
               (Aux1 == 32'd9) ? 7'b0010000: 7'b1111111;

  assign saida2 = (Aux2 == 32'd0) ? 7'b1000000:
               (Aux2 == 32'd1) ? 7'b1001111:
               (Aux2 == 32'd2) ? 7'b0100100:
               (Aux2 == 32'd3) ? 7'b0110000:
               (Aux2 == 32'd4) ? 7'b0011001:
               (Aux2 == 32'd5) ? 7'b0010010:
               (Aux2 == 32'd6) ? 7'b0000010:
               (Aux2 == 32'd7) ? 7'b1111000:
               (Aux2 == 32'd8) ? 7'b0000000:
               (Aux2 == 32'd9) ? 7'b0010000: 7'b1111111;

endmodule //Conversor_7Seg
