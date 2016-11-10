module gate_ID_EX (

  output        regWrite_EX,
  output        memtoReg_EX,
  output        memWrite_EX,
  output        branch_EX,
  output [2:0]  aLUControl_EX,
  output        aLUSrc_EX,
  output        regDst_EX,
  output [31:0] readData1Out_EX,
  output [31:0] readData2Out_EX,
  output [4:0]  instruction_Rt_EX,
  output [4:0]  instruction_Rd_EX,
  output [31:0] signExtendOut_EX,
  output        pcPlus4_EX,
  input         clk,
  input         regWrite_ID,
  input         memtoReg_ID,
  input         memWrite_ID,
  input         branch_ID,
  input         aLUControl_ID,
  input         aLUSrc_ID,
  input         regDst_ID,
  input  [31:0] readData1Out_ID,
  input  [31:0] readData2Out_ID,
  input  [4:0]  instruction_Rt_ID,
  input  [4:0]  instruction_Rd_ID,
  input  [31:0] signExtendOut_ID,
  input         pcPlus4_ID
  
);
  

  always @ ( posedge clk ) begin

    regWrite_EX      <= regWrite_ID;
    memtoReg_EX      <= memtoReg_ID;
    memWrite_EX      <= memWrite_ID;
    branch_EX        <= branch_ID;
    aLUControl_EX    <= aLUControl_ID;
    aLUSrc_EX        <= aLUSrc_ID;
    regDst_EX        <= regDst_ID;
    readData1Out_EX  <= readData1Out_ID;
    readData2Out_EX  <= readData2Out_ID;
    instruction_Rt_EX <= instruction_Rt_ID;
    instruction_Rd_EX <= instruction_Rd_ID;
    signExtendOut_EX  <= signExtendOut_ID;
    pcPlus4_EX     <= pcPlus4_ID;

  end
endmodule