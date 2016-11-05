// TODO: Move these tests into the main file after we consolidate.
// Resources:
// - MIPS instructions: http://www.mrc.uidaho.edu/mrc/people/jff/digital/MIPSir.html

`include "cpu.v"

module testCPU ();

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

  // Registers.
  reg [4:0] rS;
  reg [4:0] rT;
  reg [4:0] rD;

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
    instruction = { `CMD_j, jumpTarget };
    completeInstructionCycle();

    if (pc !== {4'b0, 26'd203, 2'b0}) begin
      dutPassed = 0;
    end

    // JR ======================================================================
    // Jump to the address contained in register $s.
    // RTL:
    //   PC = $s;

    instruction = { `CMD_jr, rS, 21'b0 };
    completeInstructionCycle();

    // TODO: Match to the actual register value.
    if (pc !== {4'b0, 28'b0}) begin
      dutPassed = 0;
    end

    // JAL =====================================================================
    // Jumps to the calculated address and stores the return address in $31.
    // RTL:
    //   $31 = PC + 4;
    //   PC = (PC & 0xf0000000) | (target << 2);

    jumpTarget = 26'd214;
    instruction = { `CMD_jal, jumpTarget };
    completeInstructionCycle();

    if (pc !== {4'b0, 26'd214, 2'b0}) begin
      dutPassed = 0;
    end

    // TODO: Determine how to test the return address $31.

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
    // Subtracts two registers and stores the result in a register.
    // RTL:
    //   $d = $s - $t;
    //   PC = nPC;
    //   nPC = nPC + 4;

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
