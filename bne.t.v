`include "bne.v"

module testBne();

	reg programCounter;
	reg A; //RegFile[rs]
	reg B; //RegFile[rt]
	wire res;
	reg imm;


	bne dut(.programCounter(programCounter),
			.A(A),
			.B(B),
			.res(res),
			.imm(imm));


	initial clk=0;
    always #10 clk=!clk;    // 50MHz Clock

	reg dutPassed;

	initial begin
		$dumpfile("bne.vcd");
		$dumpvars;

		dutPassed = 1;

		//Test 1: Check if Res is PC+imm
		if (res !== (programCounter+imm)) begin
			dutPassed = 0;
			$display("programCounter: %d", programCounter);
			$display("imm: %d", imm);
			$display("res: %d", res);

		end

		//Test 2: Check if it branches when rs != rt.
		if (A!==B && programCounter !== res) begin
			dutPassed = 0;
			$display("programCounter: %d", programCounter);
			$display("res: %d", res);

		end

		$display("Did all tests pass? %b", dutPassed);
        $finish;

	end