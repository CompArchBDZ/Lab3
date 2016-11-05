`include "slt.v"

module testSlt();

	reg A;
	reg B;
	reg rd;
	wire res;



	add dut (.A(A),
			 .B(B),
			 .rd(rd),
			 .res(res));

	initial clk=0;
	always #10 clk=!clk; //50MHz clock

	reg dutPassed;

	initial begin
		$dumpfile("add.vcd");
		$dumpvars;

		dutPassed = 1;

		//Check if rd = 1 when A < B. 
		if (A < B && rd !== 1) begin //rd? res?
			dutPassed = 0;
		end

		//Test 2: Check if result is stored in register.
		if (res !== rd) begin
			dutPassed = 0;
			
		end

		$display("Did all tests pass? %b", dutPassed);
        $finish;
	end








