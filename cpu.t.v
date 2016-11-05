// TODO: Move these tests into the main file after we consolidate.

`include "cpu.v"

module testDavidsStuff ();

  reg clk;

  // DUT.
  CPU dut ();

  // Start the clock.
  initial clk = 1;
  always #1 clk = !clk;

  reg dutPassed;

  initial begin

    $dumpfile("cpu.vcd");
    $dumpvars;
    dutPassed = 1;

    // LW ======================================================================

    // SW ======================================================================

    // J =======================================================================

    // JR ======================================================================

    // JAL =====================================================================

    // BNE =====================================================================

    reg [5:0] CMD_BNE = 6'd4;

    instruction = { CMD_BNE, rS, rT, imm };
    completeInstructionCycle();

    if (rD !== (pc+(imm<<2)) begin
      dutPassed = 0;
      $display("pc: %d", pc);
      $display("imm: %d", imm);
      $display("rD: %d", rD);

    end

    // XORI ====================================================================

    // ADD =====================================================================

    reg [5:0] CMD_ADD = 6'd5;
    instruction = { CMD_ADD, rS, rT, rD };
    completeInstructionCycle();

    if (rD !== rS + rT) begin
      dutPassed = 0;
      $display("Sum is not correct.");
      $display("rD: %d", rD);
      $display("rS: %d", rS);
      $display("rT: %d", rT);

    end


    // SUB =====================================================================

    // SLT =====================================================================

    reg [5:0] CMD_SLT = 6'd6;
    instruction = { CMD_SLT, rS, rT, rD };
    completeInstructionCycle();

    dutPassed = 0;

    if (rS < rT && rD !== 1) begin
      dutPassed = 0;
      $display("rS: %d", rS);
      $display("rT: %d", rT);
      $display("rD: %d", rD);
    end
    
    $finish;
  end
endmodule
