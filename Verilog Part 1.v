module ECE2072_Assignment_JeremyVasic(CLOCK_50, KEY, SW, LEDR, LEDG, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7);
	input CLOCK_50;
	input [3:0] KEY;
	input [17:0] SW;
	output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7;
	output [17:0] LEDR;
	output [7:0] LEDG;

	assign LEDG[3:0] = ~KEY[3:0]; 
	assign LEDR[17:0] = SW[17:0];

	
	
		// Student to instantiate modules here for Parts 1, 2 and 3.
		MyPart1 p1(.iClk(CLOCK_50), .iRst(KEY[0]), .iErrorCodes(SW[17:16]), .iEnableDisplay(SW[15]), .iFreezeDisplay(SW[14]), .oHEX0(HEX0), .oHEX1(HEX1), .oHEX2(HEX2), .oHEX3(HEX3));
		//\\ Part 1 Legend: SW[17:16]=error codes, SW[15]=enable, SW[14]=freeze output, KEY[0]=reset,

	
endmodule

module MyPart1(iClk, iRst, iErrorCodes, iEnableDisplay, iFreezeDisplay, oHEX0, oHEX1, oHEX2, oHEX3);
	input iClk, iRst, iEnableDisplay, iFreezeDisplay;
	input [1:0] iErrorCodes;
	output [6:0] oHEX0, oHEX1, oHEX2, oHEX3;

		// Student to complete this module .....
		reg Time_100msec16;
		Timer f0(.iClk(iClk), .iRst(iRst), .iRstCE(posedge iClk), .oTime_100msec16(Time_100msec16));
		DisplayTimerError f1(.iCLK(iClk), .iSWEntryError(iErrorCodes), .iEnable(iEnableDisplay), .iFreezeDisplayTimer(iFreezeDisplay), .iTimer_100msec(Time_100msec16), .oHEX0(oHEX0), .oHEX1(oHEX1), oHEX2(oHEX2), oHEX3(oHEX3;));
		
		assign HEX7 = 7'b0010010; //:5 Replacing P1 with my student ID# 277714{58}
		assign HEX7 = 7'b0000000; //:8
		
		
		//: Notes:
		//: .iSWEntryError(iErrorCodes)?? Or do you need to implement boolean logic to check if an error has occured
		//: .iRstCE(posedge iClk), reset only on clock edge???
	
	endmodule

	

//**********************************************************************************************************
//   MODULE:  NextIDdualOctal
//   DESCRIPTION: Generates a 6 bit number based on a student ID number using multiplication by 7.  
//				After iRst=1, and the first iNext=1 request, the first ID digit is used to generate the oIDdualOctal.
//				The next in the sequence is obtained when iNext=1 on a iClk 0->1 edge.
//				Refer to the assignment question for more information.
//**********************************************************************************************************
module NextIDdualOctal(iClk, iRst, iNext, oIDdualOctal);
	input iClk, 		// System clock
		iNext,		// Next value to be produced on 0->1 clock edge when ClockEnable=1
		iRst;			// Resets to starting state.

	output reg [5:0] oIDdualOctal; // The student ID value being produced
	
	/***STUDENT TO COMPLETE***/
	
	/*........*/
	
	
	/***STUDENT TO COMPLETE***/
endmodule
	
	
//**********************************************************************************************************
//   MODULE:  FSM
//   DESCRIPTION: Finite state machine to control the whole circuit.  Note this is a Moore FSM since the outputs
//						are a combinational function of the state only (and not directly the inputs).  Inputs are used
//						to determine the next state.  Some outputs are active for just one clock cycle.  All outputs 
//                should be given a default value that is inactive so that states only specify active outputs.
//                The operation is summarised here but is described fully in the assignment notes.  
//						1. Initially the display is blank for a fixed time.  
//						2. New dual octal numbers are requested by the FSM and displayed, prompting the user 
//							to respond by setting appropriate switches in SW[3:0] and then changing the submit switch SW[17].
//                		3. The time from display to correct switches(Cognition delay) and change in submit switch is displayed
// 							in 100 milliseconds units using the iTimer16 input.
//						4. If the user sets a switch incorrectly (error 1) or does not respond within 8 seconds (error 2)
//							an error is displayed instead of the Cognition delay.
//						5. Go back to step 1.
//**********************************************************************************************************
module FSM(iClk, iRst, iUser4bitSW, iSubmitSW, iTimer16, iDualOctGenerated, oResetTimer, oUser4bitNumError, 
			  oFreezeDisplayTimer, oBlankOctNumsDisplay, oShowTimerErrorDisplay, oNewOctNumsReq, oState);

input iClk, iRst, iSubmitSW;  // iSubmitSW is the user operated submit switch - a change indicates new 4 bit number is available from user
input [3:0] iUser4bitSW; 	// 4 bit number on switches from the user
input [15:0] iTimer16;       	// time since oResetTimer becoming 0 in milliseconds 
input [5:0] iDualOctGenerated; // 4 bit number expected from user
output reg 	oResetTimer, 				// zero timer value.
				oFreezeDisplayTimer, 	// capture timer value for display if oShowTimerErrorDisplay=1.
				oBlankOctNumsDisplay, 	// blank the octal numbers display.
				oNewOctNumsReq, 		// a new 4 bit number will be generated on the next clock edge
				oShowTimerErrorDisplay;	// Show the captured time or error 
output reg [1:0] oUser4bitNumError;  	// 0 for no error, 1 wrong switch pressed, 2 timeout reached with no switches 1.


output [/* student to complete */:0] oState;	// state available only for debugging.

assign oState = state;

// Use parameters for allocating sensible state names to state integers, eg RESET_STATE=0.  
// The number state bits needs to be sufficient to store the largest state value.
parameter	RESET_STATE						=0; /* student to complete other states here */; 


reg [/* student to complete */:0] state, next_state;

//  ...... other parameters and signals declared here 



always@(state, iTimer16, iUser4bitSW, iDualOctGenerated, iSubmitSW) begin
	//default control actions are no action, for exxample:
		oFreezeDisplayTimer=0;

		
		// ... many more
		
	case(state)
		RESET_STATE:
			begin
				// student to complete outputs and next state ....

			end
			
			// other state cases  here .......
			
	endcase
end

always @(posedge iClk) begin  // Update state on iClk edge
	if (iRst) state <= RESET_STATE;
	else state <= next_state;
end
endmodule
	
	
	
//***************************         S T O P          ***************************************
// ********************** DO NOT MODIFY BELOW THIS LINE  *************************************
//  **************  DO NOT SUBMIT THESE MODULES BELOW WHEN UPLOADING YOUR ASSIGNMENT CODE ****
	
	
	
	
module CognitionTimer(iClk, iRst, iChooseRandID, iUser4bitSW, iSubmitSW, oHEX0, oHEX1, oHEX2, oHEX3, oHEX4, oHEX5, oHEX6, oHEX7);
	input iClk, iRst, iChooseRandID, iSubmitSW;
	input [3:0] iUser4bitSW;
	output [6:0] oHEX0, oHEX1, oHEX2, oHEX3, oHEX4, oHEX5, oHEX6, oHEX7;
	
	reg [3:0] temp, temp_b, sync_user4bitSW;
	reg temp_r, sync_reset, temp_sub, sync_submit;
	always@(posedge iClk) begin  // synchronise asynchronous inputs to the clock using two FFs per input.
								//  This allows one clock period for metastable settling time.
		temp_b 			<= iUser4bitSW;
		sync_user4bitSW <= temp_b;
		temp_r 			<= iRst;
		sync_reset 		<= temp_r;
		temp_sub 		<= iSubmitSW;
		sync_submit 	<= temp_sub;
	end
	
	wire [15:0] time_100msec;
	wire reset_timer, freeze_display_timer, blank_display, new_oct_nums_req, enable_timer_display;
	wire [5:0] dual_oct_generated;
	
	wire [3:0] state;
	wire [1:0] SWuser_entry_error;
	
	Timer t0(
		.iClk(iClk), 
		.iRst(reset_timer | sync_reset), 
		.iRstCE(0), 
		.oTime_100msec16(time_100msec)
	);
	
	DisplayTimerError d0(
		.iClk(iClk), 
		.iSWEntryError(SWuser_entry_error), 
		.iEnable(enable_timer_display), 
		.iFreezeDisplayTimer(freeze_display_timer), 
		.iTimer_100msec(time_100msec),
		.oHEX0(oHEX0), .oHEX1(oHEX1), .oHEX2(oHEX2), .oHEX3(oHEX3)
	);
	
	FSM fsm0(
		.iClk(iClk), 
		.iRst(sync_reset), 
		.iUser4bitSW(sync_user4bitSW),
		.iSubmitSW(sync_submit),	
		.iTimer16(time_100msec), 
		.iDualOctGenerated(dual_oct_generated), 
		.oResetTimer(reset_timer), 
		.oUser4bitNumError(SWuser_entry_error), 
		.oFreezeDisplayTimer(freeze_display_timer), 
		.oBlankOctNumsDisplay(blank_display), 
		.oShowTimerErrorDisplay(enable_timer_display), 
		.oNewOctNumsReq(new_oct_nums_req),
		.oState(state)
	);

	OctNumbersGenerationDisplay b0(
		.iClk(iClk), 
		.iRst(sync_reset), 
		.iChooseRandID(iChooseRandID),
		.iBlankDisplay(blank_display), 
		.iNewOctNumsReq(new_oct_nums_req), 
		.oDualOctGenerated(dual_oct_generated), 
		.oHEXA(oHEX5), .oHEXB(oHEX4)
	);
// Hexdisplay h1(state, oHEX7);
	assign oHEX7 = 7'b1111111;
	assign oHEX6 = 7'b1111111;

endmodule

//**********************************************************************************************************
//   MODULE:  OctNumbersGenerationDisplay
//   DESCRIPTION: Generates a new pair of octal numbers for display 
//      when iNewOctNumsReq=1 using a random number generator or ID based generator.
//		iChooseRandID selects between them. 
//		The octal numbers are shown on a seven segement displays oHEXA and oHEXB.  
//		When iBlankDisplay=1 nothing is displayed.
//						
//**********************************************************************************************************
module OctNumbersGenerationDisplay(iClk, iRst, iBlankDisplay, iNewOctNumsReq, iChooseRandID, oDualOctGenerated, oHEXA, oHEXB);
	input iClk, iRst, iBlankDisplay, iNewOctNumsReq, iChooseRandID;
	output reg [5:0] oDualOctGenerated;
	output [6:0] oHEXA, oHEXB;
	
	wire [5:0] rand6b, IDdualOct;
	reg [5:0] num_random;
	
	Random6bit r0(
		.iClk(iClk), 
		.iRst(iRst), 
		.oNum(rand6b)
	);
	NextIDdualOctal n0(
		.iClk(iClk), 
		.iRst(iRst), 
		.iNext(iNewOctNumsReq), 
		.oIDdualOctal(IDdualOct)
	);
	
	always@(posedge iClk)
		if (iNewOctNumsReq)
			num_random <= rand6b;
	
	always@(IDdualOct, iChooseRandID, num_random) begin		
			if (iChooseRandID) oDualOctGenerated = num_random;
			else oDualOctGenerated = IDdualOct;
	end

	wire [6:0] HEXAt, HEXBt;
	Hexdisplay h0({1'b0, oDualOctGenerated[5:3]}, HEXAt);  
	Hexdisplay h1({1'b0, oDualOctGenerated[2:0]}, HEXBt);  
	assign oHEXA = (iBlankDisplay? 7'b1111111 : HEXAt);
	assign oHEXB = (iBlankDisplay? 7'b1111111 : HEXBt);
endmodule


//**********************************************************************************************************
//   MODULE:  DisplayTimerError
//   DESCRIPTION: Displays the Cognition time in 100 msec units if there is no error.  Otherwise the error is displayed
//						on 4 seven segment displays.  Errors are:
//							switch error (Err1):  the wrong switches were set by the user
//							timeout error (Err2):  the user took longer than 5 seconds to respond.
//**********************************************************************************************************
module DisplayTimerError(iClk, iSWEntryError, iEnable, iFreezeDisplayTimer, iTimer_100msec, oHEX0, oHEX1, oHEX2, oHEX3);
	input iClk, iEnable, iFreezeDisplayTimer;
	input [1:0] iSWEntryError;
	input [15:0] iTimer_100msec;
	output [6:0] oHEX0, oHEX1, oHEX2, oHEX3;

	reg [15:0] display_time;
	
	always@(posedge iClk)
		if (!iFreezeDisplayTimer)
			display_time <= iTimer_100msec;

	Display4BCD_Error d0(
		.iValue14bit(display_time), 
		.iEn(iEnable), 
		.iError(iSWEntryError), 
		.oHEX0(oHEX0), .oHEX1(oHEX1), .oHEX2(oHEX2), .oHEX3(oHEX3)
	);
endmodule

//**********************************************************************************************************
//   MODULE:  Timer
//   DESCRIPTION: For a 50 MHz iClk, otime_100msec16 is the 16 bit elapsed
//						time in units of 100 milliseconds since the last time iRst=1.
//					iRst resets the timer on the next clock edge
//					iRstCE resets the timer on the next CE clock edge.
//**********************************************************************************************************
module Timer(iClk, iRst, iRstCE, oTime_100msec16);
	input iClk, iRst, iRstCE;
	output reg [15:0] oTime_100msec16;
	
	reg [22:0] CE_cntr;
	wire CE_100msec = (CE_cntr == 23'd5000000 - 1);  // 1 for one clock cycle every 5,000,000 clock cycles (ie 100 msec)

	always @(posedge iClk)  // Generate clock enable counter for CE_100msec
		if (CE_100msec || iRst) CE_cntr <= 23'b0;
		else CE_cntr <= CE_cntr + 1'b1;
		
	always @(posedge iClk)  // increment time every 100 msec.
			if (iRst) oTime_100msec16 <= 0;  // reset 
				else if (CE_100msec) begin
					if (iRstCE) oTime_100msec16 <= 0;
					else	oTime_100msec16 <= oTime_100msec16 + 1'b1;  // increment every 100 msec
				end
endmodule


//**********************************************************************************************************
//   MODULE:  Display4BCD_Error
//   DESCRIPTION: Displays 14 bit value as 4 decimal digits each a 7 segment display.
//						When iError is non zero, the error number is displayed instead.
//				  		When iEn=0 displays are blanked.
//**********************************************************************************************************
module Display4BCD_Error(iValue14bit, iEn, iError, oHEX0, oHEX1, oHEX2, oHEX3);
	input [13:0] iValue14bit;	// binary value to display
	input iEn;			// displays when 1, blank when 0
	input [1:0] iError;  // two bit error code for display, 00 no error.
	output [6:0] oHEX0, oHEX1, oHEX2, oHEX3;
								// Decimal digits on 7 segment displays,  oHEX3 is most significant 
								// if Value_in >= 9999, display shows 9999

	wire [6:0] HEX0t, HEX1t, HEX2t, HEX3t, HEX0e;
	wire [19:0] BCD20;
	wire [15:0] BCD16;
	
	Bin2BCD b0(iValue14bit, BCD20);
	Hexdisplay H0(BCD20[3:0], 	HEX0t);  
	Hexdisplay H1(BCD20[7:4],	HEX1t);
	Hexdisplay H2(BCD20[11:8],	HEX2t);
	Hexdisplay H3(BCD20[15:12],HEX3t);
	
	wire error_enable = !(iError == 2'b00);
	parameter [6:0] E7 = 7'b0000110;
	parameter [6:0] r7 = 7'b0101111;
	Hexdisplay H5(iError, HEX0e);
	
	assign oHEX0 = (iEn ? (error_enable? HEX0e: HEX0t) : 7'b1111111);
	assign oHEX1 = (iEn ? (error_enable? r7: HEX1t) : 7'b1111111);
	assign oHEX2 = (iEn ? (error_enable? r7: HEX2t) : 7'b1111111);
	assign oHEX3 = (iEn ? (error_enable? E7: HEX3t) : 7'b1111111);
endmodule

//**********************************************************************************************************
//   MODULE:  Bin2BCD
//   DESCRIPTION: Converts a 14 bit binary number into decimal with 5 BCD digits.
//                 This module minimises resource usage by using shifts, comparisons and adds without / % operators.  
//                 It has many levels of logic, so is slow yet much quicker than can be seen by the human eye!
//                 Adapted from http://www.eng.utah.edu/~nmcdonal/Tutorials/BCDTutorial/BCDConversion.html
//						 Beware: this code uses "for" loops -  not covered in ECE2072.  The way to interpret this is that
//                 the loops are unrolled before synthesis and new signal name versoins are used for LHS of 
//                 assignments on each iteration.  The last versions are then used to update oBCD20.
//						 After synthesis look at Bin2BCD using Quartus: Tools->Netlist viewers->RTL viewer.
//**********************************************************************************************************
module Bin2BCD(iBin14, oBCD20);
	input [13:0] iBin14;
	output reg [19:0] oBCD20;
	
	reg [13:0] bin14;
	integer i, j;
	reg [3:0] temp;
	always@(iBin14) begin
		oBCD20 = 20'b0;
		bin14 = iBin14;
		for(i=0; i<14; i=i+1) begin  // When synthesised the "for" statement is unwrapped to 14 levels of logic.
			// Add 3 to BCD digits >= 5.  After considering the upcoming *2 due to the shift left below, 
			// this converts the hexadecimal weighting of 16 between digits to decimal with a weighting of 10 between digits.
			for (j=0; j<5; j=j+1) begin  // Each BCD digit updated independently: ie parallel logic.
				temp = {oBCD20[4*j+3], oBCD20[4*j+2], oBCD20[4*j+1], oBCD20[4*j] };  //temp is 4 bit BCD digit
				if (temp > 4)
					{oBCD20[4*j+3], oBCD20[4*j+2], oBCD20[4*j+1], oBCD20[4*j] } = temp + 4'd3;
			end
			// shift left one bit
			{oBCD20, bin14} = {oBCD20, bin14} << 1;
		end
	end
endmodule

//**********************************************************************************************************
//   MODULE:  Hexdisplay
//   DESCRIPTION: converts a 4 bit BCD number to 7 segment display format
//**********************************************************************************************************
module Hexdisplay(iBinary4bit, oHex);
	input [3:0] iBinary4bit;		//the 4 bit BCD number
	output reg [6:0] oHex;	//7 segment display output	
	
	always @(iBinary4bit)
	  case (iBinary4bit)
		0: oHex <= 7'b 1000000;
		1: oHex <= 7'b 1111001;
		2: oHex <= 7'b 0100100;
		3: oHex <= 7'b 0110000;
		4: oHex <= 7'b 0011001;
		5: oHex <= 7'b 0010010;
		6: oHex <= 7'b 0000010;
		7: oHex <= 7'b 1111000;
		8: oHex <= 7'b 0000000;
		9: oHex <= 7'b 0011000;
		10: oHex <= 7'b 0001000;
		11: oHex <= 7'b 0000011;
		12: oHex <= 7'b 0100111;
		13: oHex <= 7'b 0100001;
		14: oHex <= 7'b 0000110;
		15: oHex <= 7'b 0001110;
	  endcase
endmodule

//**********************************************************************************************************
//   MODULE:  Random6bit
//   DESCRIPTION: Pseudo random 6 bit number uniformly distributed between 0 and 63.
//						Implemented with 12 LFSR.
//**********************************************************************************************************

module Random6bit(iClk, iRst, oNum);
	input iClk, iRst;
	output [5:0] oNum;
	wire  [11:0] randnum; 
	LinearFeedbackShiftRegister12 l0(.iClk(iClk), .iRst(iRst), .oLFSR12bit(randnum));
	assign oNum = {randnum[0], randnum[11], randnum[2], randnum[9], randnum[3], randnum[5]};  // jumbled mix of bits
endmodule

//**********************************************************************************************************
//   MODULE:  LinearFeedbackShiftRegister12
//   DESCRIPTION: Pseudo random number generator 0 up to 4095 based on 12 bit LFSR x12 + x11 + x10 + x4 + 1 
//     see https://en.wikipedia.org/wiki/Linear-feedback_shift_register
//**********************************************************************************************************
module LinearFeedbackShiftRegister12(iClk, iRst, oLFSR12bit);
	input iClk, iRst;
	output reg [11:0] oLFSR12bit;		// pseudo random 12 bit number based on XOR feedback.
	always @(posedge iClk)
	  if (iRst || (oLFSR12bit == 12'b0))  // want to avoid degenerate all 0s when dowloading FPGA configuration
		oLFSR12bit <= 12'b101011101101;  // seed value on reset or download to FPGA
	  else
		oLFSR12bit <= {oLFSR12bit[10:0], oLFSR12bit[11]^oLFSR12bit[10]^oLFSR12bit[9]^oLFSR12bit[3]};
endmodule

