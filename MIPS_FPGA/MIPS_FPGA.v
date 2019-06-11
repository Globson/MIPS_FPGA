`include "Modulos/ALU.v"
`include "Modulos/AND.v"
`include "Modulos/ControleALU.v"
`include "Modulos/Controller.v"
`include "Modulos/Data_Memory.v"
`include "Modulos/Ext_Sinal.v"
`include "Modulos/LeftShift2.v"
`include "Modulos/Memoria_instrucoes.v"
`include "Modulos/MUX.v"
`include "Modulos/PC.v"
`include "Modulos/Registradores.v"
`include "Modulos/Somador.v"
`include "Modulos/Somador4.v"
`include "Modulos/Conversor_7Seg.v"
`include "Modulos/Memoria_de_exibicao.v"
//=======================================================
//  This code is generated by Terasic System Builder
//=======================================================

module MIPS_FPGA(

	//////////// CLOCK //////////
	CLOCK_50,
	CLOCK2_50,
	CLOCK3_50,

	//////////// LED //////////
	LEDG,
	LEDR,

	//////////// KEY //////////
	KEY,

	//////////// SW //////////
	SW,

	//////////// SEG7 //////////
	HEX0,
	HEX1,
	HEX2,
	HEX3,
	HEX4,
	HEX5,
	HEX6,
	HEX7
);

//=======================================================
//  PARAMETER declarations
//=======================================================


//=======================================================
//  PORT declarations
//=======================================================

//////////// CLOCK //////////
input 		          		CLOCK_50;
input 		          		CLOCK2_50;
input 		          		CLOCK3_50;

//////////// LED //////////
output		     [8:0]		LEDG;
output		    [17:0]		LEDR;

//////////// KEY //////////
input 		     [3:0]		KEY;

//////////// SW //////////
input 		    [17:0]		SW;

//////////// SEG7 //////////
output		     [6:0]		HEX0;
output		     [6:0]		HEX1;
output		     [6:0]		HEX2;
output		     [6:0]		HEX3;
output		     [6:0]		HEX4;
output		     [6:0]		HEX5;
output		     [6:0]		HEX6;
output		     [6:0]		HEX7;


//=======================================================
//  REG/WIRE declarations
//=======================================================
wire clk = CLOCK_50;
reg [31:0] PCIn;
wire [31:0] PCOut;
wire Reset = ~(KEY[3]);
wire [31:0] Saida_Somador4;
wire [31:0] Instrucao;
wire [1:0] branch;
wire MemRead;
wire RegDst;
wire memToReg;
wire [1:0] ALUOp;
wire regWrite;
wire memWrite;
wire ALUSrc;
wire [4:0] writeRegister;
wire [31:0] Read_Data1_Regs_Out;
wire [31:0] Read_Data2_Regs_Out;
wire [31:0] writeData;
wire [31:0] Signal_Extented;
wire [31:0] ALUIn;
wire [3:0] OP_ALU_IN;
wire [31:0] ALUResult;
wire FlagZero;
wire [31:0] Read_DataMemory_Out;
wire [31:0] Left_Shifted2;
wire [31:0] Somador2_Out;
wire Door_Out;
wire [31:0] NextPC;
wire [31:0] saida_Memoria_Exibe;



//=======================================================
//  Structural coding
//=======================================================
PC pc(.clk(clk),.entrada(PCIn),.saida(PCOut),.reset(Reset));

Somador4 Soma4(.a(PCOut),.saida(Saida_Somador4));

Memoria_instrucoes Inst_Mem(.reset(Reset),.endereco(PCOut),.instrucao(Instrucao));

Controller controll(.Opcode(Instrucao[31:26]),.RegDst(RegDst),.Branch(branch),.MemRead(MemRead),.MemtoReg(memToReg),.ALUOp(ALUOp),.MemWrite(memWrite),.ALUSrc(ALUSrc),.RegWrite(regWrite));

MUX_5b mux5b_1(.controle(RegDst),.entrada1(Instrucao[20:16]),.entrada2(Instrucao[15:11]),.saida(writeRegister));

Registradores Regs(.reset(Reset),.clk(clk),.RegWrite(regWrite),.ReadReg1(Instrucao[25:21]),.ReadReg2(Instrucao[20:16]),.WriteReg(writeRegister),.WriteData(writeData),.ReadData1(Read_Data1_Regs_Out),.ReadData2(Read_Data2_Regs_Out));

Ext_Sinal Signal_Extenteder(.entrada(Instrucao[15:0]),.saida(Signal_Extented));

MUX_32b mux32b_2(.controle(ALUSrc),.entrada1(Read_Data2_Regs_Out),.entrada2(Signal_Extented),.saida(ALUIn));

ControleALU Control_ALU(.OpCode_ALU(ALUOp),.Func_Code(Instrucao[5:0]),.Controle_ALU(OP_ALU_IN));

ALU ALU_1(.controle(OP_ALU_IN),.a(Read_Data1_Regs_Out),.b(ALUIn),.zero(FlagZero),.saida(ALUResult));

Data_Memory Data_Mem(.reset(Reset),.Clk(clk),.MemWrite(memWrite),.MemRead(MemRead),.Address(ALUResult),.WriteData(Read_Data2_Regs_Out),.ReadData(Read_DataMemory_Out));

MUX_32b mux32b_3 (.controle(memToReg),.entrada1(ALUResult),.entrada2(Read_DataMemory_Out),.saida(writeData));

LeftShift2 Left_shift(.entrada(Signal_Extented),.saida(Left_Shifted2));

Somador ADD_1(.a(Saida_Somador4),.b(Left_Shifted2),.saida(Somador2_Out));

Door_BNE_BEQ Door1(.branch(branch),.flag(FlagZero),.out(Door_Out));

MUX_32b mux32b_4(.controle(Door_Out),.entrada1(Saida_Somador4),.entrada2(Somador2_Out),.saida(NextPC));

Mem_Exibi exibe(.resultadoALU(ALUResult),.Clk(clk),.proximo((~KEY[2])),.saida(saida_Memoria_Exibe),.reset(Reset));

//Conversor_7Seg Conv(.entrada(saida_Memoria_Exibe),.saida1(HEX1),.saida2(HEX0));

Conversor_7Seg_Melhorado ConvMe(.entrada(saida_Memoria_Exibe),.display0(HEX0),.display1(HEX1),.display2(HEX2),.display3(HEX3),.display4(HEX4),.display5(HEX5),.display6(HEX6),.display7(HEX7));


endmodule
