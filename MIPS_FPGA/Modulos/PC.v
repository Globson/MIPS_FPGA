module PC (entrada,saida,clk,reset);
  input clk,reset;
  input [31:0] entrada;
  output reg[31:0] saida;
  always @ (posedge clk) begin
    saida = entrada;
    if(reset)begin
    saida <= 0;
    end
  end
endmodule //PC
