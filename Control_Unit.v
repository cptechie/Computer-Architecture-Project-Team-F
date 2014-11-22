module Control_Unit
  (
   op_in,
   func_in,
   
   branch_out, 
   regWrite_out, 
   regDst_out, 
 //  extCntrl_out, 
   ALUSrc_out, 
   ALUCntrl_out, 
   memWrite_out,
   memRead_out,
   memToReg_out, 
   jump_out,
  // zeroselect_out
   );
   
   input [5:0]  op_in, func_in;
   
   output [3:0] ALUCntrl_out;
   reg [3:0] 	ALUCntrl_out;
   
   output 	branch_out, jump_out;				
   reg 		branch_out, jump_out;				
   
   output 	regWrite_out, regDst_out;
   reg 		regWrite_out, regDst_out;
   
   output 	ALUSrc_out;
   reg 		ALUSrc_out;
   
   output 	memWrite_out, memRead_out, memToReg_out;
   reg 		memWrite_out, memRead_out, memToReg_out;
   
 // output zeroselect_out;
 // reg zeroselect_out;

   always@*
     begin

	casex({op_in, func_in})

	  {6'b000_000, 6'b000_000}: 
	    begin       
	       regDst_out   = 0; //0 means RT  and 1 means RD
	       ALUSrc_out   = 0; //0 means REG and 1 means IMM
	       memToReg_out = 0; //0 means NO  and 1 means YES
	       regWrite_out = 0; //0 means NO  and 1 means YES
	       memWrite_out = 0; //0 means NO  and 1 means YES
	       memRead_out  = 0; //0 means NO  and 1 means YES
	       branch_out   = 0; //0 means NO  and 1 means YES
	       jump_out     = 0; //0 means NO  and 1 means YES
	      // extCntrl_out = 0; //0 means Zero-extension and 1 means Sign-extension
	       ALUCntrl_out = 4'b1000; 
	      // zeroselect_out = 0;
	    end 
	    
	  
	 //Begin R-type
	  {6'b000_000, 6'b100_000}: // ADD(R-type)
	    begin
		   regWrite_out = 1'b1;
	       regDst_out   = 1'b1;
	       ALUSrc_out   = 1'b0;
	       branch_out   = 1'b0;
	       memWrite_out = 1'b0;
	       memToReg_out = 1'b0;
	       memRead_out  = 1'b0;
	       
	       ALUCntrl_out = 4'b0000;
	       jump_out     = 1'b0;
	    // extCntrl_out = 1'b1;
	    // zeroselect_out = 1'b0;
	    end 
	  
	  {6'b000_000,6'h100_010}: // SUB(R-type)
	   begin
		   regWrite_out = 1'b1;
	       regDst_out   = 1'b1;
	       ALUSrc_out   = 1'b0;
	       branch_out   = 1'b0;
	       memWrite_out = 1'b0;
	       memToReg_out = 1'b0;
	       memRead_out  = 1'b0;
	       
	       ALUCntrl_out = 4'b0001;
	       jump_out     = 1'b0;
	     //extCntrl_out = 1'b1;
	     //zeroselect_out = 1'b0;
	    end 
	  
	  
	   {6'b000_000,6'h100_100}: // AND(R-type)
	    begin
		  regWrite_out = 1'b1;
	      regDst_out   = 1'b1;
	      ALUSrc_out   = 1'b0;
	      branch_out   = 1'b0;
	      memWrite_out = 1'b0;
	      memToReg_out = 1'b0;
	      memRead_out  = 1'b0;
	      
	      ALUCntrl_out = 4'b0010;
	      jump_out     = 1'b0;
	    //extCntrl_out = 1'b0;
	    //zeroselect_out = 1'b0;
	    end 
	    
	    
	    
	  
	  {6'b000_000,6'b101_010}: //SLT(R-type)
	    begin
	       regWrite_out = 1'b1;
	       regDst_out   = 1'b1;
	       ALUSrc_out   = 1'b0;
	       branch_out   = 1'b0;
	       memWrite_out = 1'b0;
	       memToReg_out = 1'b0;
	       memRead_out  = 1'b0;
	       
	       ALUCntrl_out = 4'b0100;
	       jump_out     = 1'b0;
	     //extCntrl_out = 1'b1;
	     //zeroselect_out = 1'b0;
	    end 
	    
	    
	  {6'b000_000,6'b100_101}: //OR(R-type)
	    begin
	       regWrite_out = 1'b1;
	       regDst_out   = 1'b1;
	       ALUSrc_out   = 1'b0;
	       branch_out   = 1'b0;
	       memWrite_out = 1'b0;
	       memToReg_out = 1'b0;
	       memRead_out  = 1'b0;
	       
	       ALUCntrl_out = 4'b0101;
	       jump_out     = 1'b0;
	     //extCntrl_out = 1'b1;
	     //zeroselect_out = 1'b0;
	    end 
	  //END R-type
	  
	  
	  //Begin I-type
	  {6'b100_011,6'bxxx_xxx}: //LW(I-type)
	    begin
		  regWrite_out = 1'b1;
	      regDst_out   = 1'b0;
	      ALUSrc_out   = 1'b1;
	      branch_out   = 1'b0;
	      memWrite_out = 1'b0;
	      memToReg_out = 1'b1;
	      memRead_out  = 1'b1;
	     
	      ALUCntrl_out = 4'b1000;
	      jump_out     = 1'b0;
	    //extCntrl_out = 1'b1;
	    //zeroselect_out = 1'b0;
	    end 
	    
	    
	  {6'b101_011,6'bxxx_xxx}: //SW(I-type)
	    begin
	      regWrite_out = 1'b0;
	      regDst_out   = 1'bx;
	      ALUSrc_out   = 1'b1;
	      branch_out   = 1'b0;
	      memWrite_out = 1'b1;
	      memToReg_out = 1'bx;
	      memRead_out  = 1'b0;
	      
	      ALUCntrl_out = 4'b1000;
	      jump_out     = 1'b0;
	    //extCntrl_out = 1'b1;
	    //zeroselect_out = 1'b0;
	    
	    end 
	    
	   {6'b001_000, 6'bxxx_xxx}: // ADDI(I-type)
	    begin
		   regWrite_out = 1;
	       regDst_out   = 0;
	       ALUSrc_out   = 1;
	       branch_out   = 0;
	       memWrite_out = 0;
	       memToReg_out = 0;
	       memRead_out  = 0;
	       
	       ALUCntrl_out = 4'b0000;
	       jump_out     = 0;
	     //extCntrl_out = 1;
	     //zeroselect_out = 0;
	    end 	  	  
	    
	  {6'b000_100,6'bxxx_xxx}: //BEQ(I-type)
	    begin
		  regWrite_out = 1'b0;
	      regDst_out   = 1'bx;
	      ALUSrc_out   = 1'b0;
	      branch_out   = 1'b1;
	      memWrite_out = 1'b0;
	      memToReg_out = 1'bx;
	      memRead_out  = 1'b0;
	      
	      ALUCntrl_out = 4'b1000;
	      jump_out     = 1'b0;
	    //extCntrl_out = 1'b1;
	    //zeroselect_out = 1'b0;
	    end
	    
		//End I-type
	    
	    
	    //Begin J-type
    {6'b000_100,6'bxxx_xxx}: //J(J-type)
	    begin
	      regWrite_out = 1'b0;
	      regDst_out   = 1'bx;
	      ALUSrc_out   = 1'bx;
	      branch_out   = 1'b0;
	      memWrite_out = 1'b0;
	      memToReg_out = 1'bx;
	      memRead_out  = 1'b0;
	     
	      ALUCntrl_out = 4'bxxx;
	      jump_out     = 1'b1;
	    //extCntrl_out = 1'b1;
	    //zeroselect_out = 1'b0;
	    end 
	    
	    
	    
	    
	    
	  
	  default:  
	    begin  
			   regWrite_out = 1'bx;
	           regDst_out   = 1'bx;
               ALUSrc_out   = 1'bx;
               branch_out   = 1'bx;
               memWrite_out = 1'bx;
               memToReg_out = 1'bx;
               memRead_out  = 1'bx;
              
               ALUCntrl_out = 4'bxxxx;
               jump_out     = 1'bx;
             //extCntrl_out = 1'bx;
             //zeroselect_out = 1'b0;
	    end 
	  
	endcase
		
     end 
      
endmodule 


