`include "add.v"

module testAdd();

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

		//Test 1: Check if A + B  = res.
		if ((A+B) !== res) begin //rd? res?
			dutPassed = 0;
		end

		//Test 2: Check if the result gets stored in the 
		// register.
		if (res !== rd) begin
			dutPassed = 0;
			$display("Result is not stored in register 
			properly.");
		end

		$display("Did all tests pass? %b", dutPassed);
        $finish;
	end








