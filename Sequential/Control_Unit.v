module Control_Unit
  (
   op_in,
   func_in,
   
   branch, 
   regWrite, 
   regDst, 
   ALUSrc, 
   ALUCntrl, 
   memWrite,
   memRead,
   memToReg, 
   jump,
   );
   
   input [5:0]  op_in, func_in;
   
   output [3:0] ALUCntrl;
   reg [3:0] 	ALUCntrl;
   
   output 	branch, jump;				
   reg 		branch, jump;				
   
   output 	regWrite, regDst;
   reg 		regWrite, regDst;
   
   output 	ALUSrc;
   reg 		ALUSrc;
   
   output 	memWrite, memRead, memToReg;
   reg 		memWrite, memRead, memToReg;


   always@*
     begin

	casex({op_in, func_in})

	  {6'b000_000, 6'b000_000}: 
	    begin       
	       regDst   = 0; //0 means RT  and 1 means RD
	       ALUSrc   = 0; //0 means REG and 1 means IMM
	       memToReg = 0; //0 means NO  and 1 means YES
	       regWrite = 0; //0 means NO  and 1 means YES
	       memWrite = 0; //0 means NO  and 1 means YES
	       memRead  = 0; //0 means NO  and 1 means YES
	       branch   = 0; //0 means NO  and 1 means YES
	       jump     = 0; //0 means NO  and 1 means YES
	       ALUCntrl = 4'b1111; 
	    end 
	    
	  
	 //Begin R-type
	  {6'b000_000, 6'b100_000}: // ADD(R-type)
	    begin
		   regWrite = 1'b1;
	       regDst   = 1'b1;
	       ALUSrc   = 1'b0;
	       branch   = 1'b0;
	       memWrite = 1'b0;
	       memToReg = 1'b0;
	       memRead  = 1'b0;
	       ALUCntrl = 4'b0000;
	       jump     = 1'b0;
	    end 
	  
	   {6'b000_000,6'b100_010}: // SUB(R-type)
	   begin
		   regWrite = 1'b1;
	       regDst   = 1'b1;
	       ALUSrc   = 1'b0;
	       branch   = 1'b0;
	       memWrite = 1'b0;
	       memToReg = 1'b0;
	       memRead  = 1'b0;	       
	       ALUCntrl = 4'b0001;
	       jump     = 1'b0;
	    end 
	  
	  
	   {6'b000_000,6'b100_100}: // AND(R-type)
	    begin
		  regWrite = 1'b1;
	      regDst   = 1'b1;
	      ALUSrc   = 1'b0;
	      branch   = 1'b0;
	      memWrite = 1'b0;
	      memToReg = 1'b0;
	      memRead  = 1'b0;      
	      ALUCntrl = 4'b0010;
	      jump     = 1'b0;
	    end 
	    
	    
	    
	  
	  {6'b000_000,6'b101_010}: //SLT(R-type)
	    begin
	       regWrite = 1'b1;
	       regDst   = 1'b1;
	       ALUSrc   = 1'b0;
	       branch   = 1'b0;
	       memWrite = 1'b0;
	       memToReg = 1'b0;
	       memRead  = 1'b0;       
	       ALUCntrl = 4'b0100;
	       jump     = 1'b0;
	    end 
	    
	    
	  {6'b000_000,6'b100_101}: //OR(R-type)
	    begin
	       regWrite = 1'b1;
	       regDst   = 1'b1;
	       ALUSrc   = 1'b0;
	       branch   = 1'b0;
	       memWrite = 1'b0;
	       memToReg = 1'b0;
	       memRead  = 1'b0;	       
	       ALUCntrl = 4'b0101;
	       jump     = 1'b0;
	    end 
	  //END R-type
	  
	  
	  //Begin I-type
	  {6'b100_011,6'bxxx_xxx}: //LW(I-type)
	    begin
		  regWrite = 1'b1;
	      regDst   = 1'b0;
	      ALUSrc   = 1'b1;
	      branch   = 1'b0;
	      memWrite = 1'b0;
	      memToReg = 1'b1;
	      memRead  = 1'b1;	     
	      ALUCntrl = 4'b1000;
	      jump     = 1'b0;

	    end 
	    
	    
	  {6'b101_011,6'bxxx_xxx}: //SW(I-type)
	    begin
	      regWrite = 1'b0;
	      regDst   = 1'bx;
	      ALUSrc   = 1'b1;
	      branch   = 1'b0;
	      memWrite = 1'b1;
	      memToReg = 1'bx;
	      memRead  = 1'b0;	      
	      ALUCntrl = 4'b1000;
	      jump     = 1'b0;
	    
	    end 
	    
	   {6'b001_000, 6'bxxx_xxx}: // ADDI(I-type)
	    begin
		   regWrite = 1;
	       regDst   = 0;
	       ALUSrc   = 1;
	       branch   = 0;
	       memWrite = 0;
	       memToReg = 0;
	       memRead  = 0;	       
	       ALUCntrl = 4'b0000;
	       jump     = 0;
	    end 	  	  
	    
	  {6'b000_100,6'bxxx_xxx}: //BEQ(I-type)
	    begin
		  regWrite = 1'b0;
	      regDst   = 1'bx;
	      ALUSrc   = 1'b0;
	      branch   = 1'b1;
	      memWrite = 1'b0;
	      memToReg = 1'bx;
	      memRead  = 1'b0;	      
	      ALUCntrl = 4'b1000;
	      jump     = 1'b0;
	    end
	    
		//End I-type
	    
	    
	    //Begin J-type
    {6'b000_010,6'bxxx_xxx}: //J(J-type)
	    begin
	      regWrite = 1'b0;
	      regDst   = 1'bx;
	      ALUSrc   = 1'bx;
	      branch   = 1'b0;
	      memWrite = 1'b0;
	      memToReg = 1'bx;
	      memRead  = 1'b0;	     
	      ALUCntrl = 4'bxxxx;
	      jump     = 1'b1;
	    end 
	    
	  default:  
	    begin  
			   regWrite = 1'bx;
	           regDst   = 1'bx;
               ALUSrc   = 1'bx;
               branch   = 1'bx;
               memWrite = 1'bx;
               memToReg = 1'bx;
               memRead  = 1'bx;
               ALUCntrl = 4'bxxxx;
               jump     = 1'bx;
	    end 
	  
	endcase
		
     end 
      
endmodule 