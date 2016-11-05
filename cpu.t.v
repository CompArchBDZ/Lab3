// TODO: Move these tests into the main file after we consolidate.
// Resources:
// - MIPS instructions: http://www.mrc.uidaho.edu/mrc/people/jff/digital/MIPSir.html

`include "cpu.v"

module testDavidsStuff ();

  // INIT ======================================================================

  wire [31:0] pc;

  reg clk;
  reg [31:0] instruction;

  // DUT.
  CPU dut (
    .pc(pc),
    .clk(clk),
    .instruction(instruction)
  );

  // HELPERS ===================================================================

  // Commands.
  reg [5:0] CMD_JUMP = 6'd1;

  reg        dutPassed;
  reg [25:0] jumpTarget;

  task completeInstructionCycle;
    begin
      // TODO: Update this time to the correct length of our instruction cycle.
      #200;
    end
  endtask

  // Start the clock.
  initial clk = 1;
  always #1 clk = !clk;

  initial begin

    $dumpfile("cpu.vcd");
    $dumpvars;
    dutPassed = 1;

    // LW ======================================================================

    // SW ======================================================================

    // J =======================================================================
    // Jumps to the calculated address.
    // RTL:
    //   PC = (PC & 0xf0000000) | (target << 2);

    jumpTarget = 26'd203;
    instruction = { CMD_JUMP, jumpTarget };
    completeInstructionCycle();

    if (pc !== {4'b0, 26'd203, 2'b0}) begin
      dutPassed = 0;
    end

    // JR ======================================================================
    // Jump to the address contained in register $s.
    // RTL:
    //   PC = $s;

    // JAL =====================================================================
    // Jumps to the calculated address and stores the return address in $31.
    // RTL:
    //   $31 = PC + 4;
    //   PC = (PC & 0xf0000000) | (target << 2);

    // BNE =====================================================================

    // XORI ====================================================================

    // ADD =====================================================================

    // SUB =====================================================================
    // Subtracts two registers and stores the result in a register.
    // RTL:
    //   $d = $s - $t;
    //   PC = nPC;
    //   nPC = nPC + 4;

    // SLT =====================================================================

    $finish;
  end
endmodule