module Control_Unit(
op_in,
func_in,
branch_out, 
regWrite_out, 
regDst_out, 
ALUSrc_out, 
ALUOp_out, 
memWrite_out,
memToReg_out, 
jump_out
);
   
input [5:0] op_in, func_in;
   
output [1:0] ALUOp_out;
output branch_out, jump_out;				
output regWrite_out, regDst_out; 
output ALUSrc_out;
output memWrite_out, memToReg_out;


parameter
ADD		= 6'b100_000,
SUB		= 6'b100_010,
OR		= 6'b100_101,
SLT		= 6'b100_010,
AND		= 6'b100_100,
ADDI	= 6'b001_000,
LW		= 6'b100_011,
SW		= 6'b101_011,
BEQ		= 6'b000_100,
J		= 6'b000_010;

assign regWrite_out = 	(op_in == ADDI)	||
						(op_in == LW)	||
						(op_in == 6'b000_000);
						

assign regDst_out = 	op_in == 6'b000_000;
						 
assign ALUSrc_out = 	(op_in == ADDI)	||
						(op_in == LW)	||
						(op_in == SW);
						
assign branch_out = 	op_in == BEQ;
						
assign memWrite_out = 	op_in == SW;
						
assign memToReg_out = 	op_in == LW;
						
assign ALUOp_out[1] = 	op_in != 6'b000_000;
assign ALUOp_out[0] = 	op_in == BEQ;
						
assign jump_out		= 	op_in == J;

endmodule 


