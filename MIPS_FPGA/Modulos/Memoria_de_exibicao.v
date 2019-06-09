module Mem_Exibi(resultadoALU,Clk,proximo,saida,reset);
  input [31:0] resultadoALU;
  input Clk,proximo,reset;
  output reg [31:0]saida;
  reg [31:0]Mem[0:25];
  integer i = 26;
  integer j = 0;

  always @ ( negedge Clk ) begin
    if(i<25) begin
      Mem[i] <= resultadoALU;
      i <= i + 1;
    end
    else if(reset) begin
      i<=0;
    end
  end

  always @ (posedge proximo) begin
    if(j<25) begin
      saida <= Mem[j];
      j <= j + 1;
    end

    else begin
      j <= 0;     //tirar esse pedaço caso n queira repetição de resultados.
    end
  end


endmodule //Mem_Exibi
