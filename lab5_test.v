/*  lab5_test.v
    ECE/ENGRD 2300, Spring 2014
    
    Authors: Douglas L. Long, Saugata Ghose
    Last modified: April 17, 2014
    
    Description: Test bench for single cycle processor.
*/

// sets the granularity at which we simulate
`timescale 1 ns / 1 ps


// define a constant for use within the test bench
`define CHECK 1 


// name of the top-level module; for us it should always be <module name>_test
// this top-level module should have no inputs or outputs; only internal signals are needed
module lab5_test();

  // for all of your input pins, declare them as type reg, and name them identically to the pins
  reg  [7:0] IOA;
  reg  [7:0] IOB;
  reg        CLK50;
  reg        CLK_SEL;
  reg        EN_L;
  reg        RESET;
  reg  [7:0] finalPC;

  // for all of your output pins, declare them as type wire so ModelSim can display them
  wire        CLK;
  wire [7:0]  PC;
  wire [7:0]  NextPC;
  wire [7:0]  DataA;
  wire [7:0]  DataB;
  wire [7:0]  DataC;
  wire [7:0]  DataD;
  wire [7:0]  Din;
  wire [15:0] Iin;
  wire [7:0]  IOC;
  wire [7:0]  IOD;
  wire [7:0]  IOE;
  wire [7:0]  IOF;
  wire [7:0]  IOG;
  wire [7:0]  IOH;
  wire        WE;

  
  // declare a sub-circuit instance (Unit Under Test) of the circuit that you designed
  // make sure to include all ports you want to see, and connect them to the variables above
  lab5 UUT(
    .CLK50(CLK50),
    .CLK_SEL(CLK_SEL),
    .CLK(CLK),
    .RESET(RESET),
    .EN_L(EN_L),
    .PC(PC),
    .NextPC(NextPC),
    .Iin(Iin),
    .IOA(IOA),
    .IOB(IOB),
    .DataA(DataA),
    .DataB(DataB),
    .DataC(DataC),
    .DataD(DataD),
    .Din(Din),
    .MW(MW),
    .IOC(IOC),
    .IOD(IOD),
    .IOE(IOE),
    .IOF(IOF),
    .IOG(IOG),
    .IOH(IOH)
  );
  
  // ALL of the initial and always blocks below will work in parallel.
  //   Starting at time t = 0, they will all start counting the number
  //   of ticks.

  
  // CLK50: generate a 50 MHz clock (rising edge does not start until
  //   10 ticks (10 ns) into simulation, and each clock cycle lasts for
  //   20 ticks (20 ns)
  initial begin
  $dumpvars;
    CLK50 = 1'b0;
    forever begin
      #10
      CLK50 = ~CLK50;
    end
  end

  
  // CLK_SEL: choose simulation mode
  // remember that for simulation we will use 1'b1 (10MHz)
  initial
  begin
    CLK_SEL = 1'b1;
  end 


  // we tell the test bench when to stop; if a loop never reaches the
  //   last instruction, we will stop after 500 cycles to make sure the
  //   test bench doesn't run forever...
  initial begin 
    finalPC = 8'd254;
    #50000 $finish;
  end 


  // RESET: make sure the processor is reset at the beginning
  initial begin
    RESET = 1'b1;
    RESET = #200 1'b0;
  end 

  
  // EN_L: we simulate some occasional events where the EN_L button
  //   is pressed in order to move on from the HALT instruction; these
  //   don't matter for any other instruction...
  initial begin
    EN_L = 1'b1; 
    #200
    EN_L = 1'b0;
    #400
    EN_L = 1'b1;
    #1400
    EN_L = 1'b0;
    #200
    EN_L = 1'b1;
    #1800
    EN_L = 1'b0;
    #200
    EN_L = 1'b1;
    #1800
    EN_L = 1'b0;
    #200
    EN_L = 1'b1;
    #1800
    EN_L = 1'b0;
    #200
    EN_L = 1'b1;
    #1800
    EN_L = 1'b0;
    #200
    EN_L = 1'b1;
    #1800
    EN_L = 1'b0;
    #200
    EN_L = 1'b1;
    #1800
    EN_L = 1'b0;
    #200
    EN_L = 1'b1;
    #1800
    EN_L = 1'b0;
    #200
    EN_L = 1'b1;   
  end 

  // IOA: starting value for input IOA; change this if you want to
  //   test how your program operates for different values of inputs
  initial begin
    IOA = 8'b010;
  end 

  // IOB: starting value for input IOB; change this if you want to
  //   test how your program operates for different values of inputs
  initial begin
    IOB = 8'b11;
  end 

  
  // ISA EMULATOR: the following code calculates just how your processor
  //   should behave, so we can use that to compare against what your
  //   processor is actually doing
  
  // Fair warning: the code below looks nothing like the code you will
  //   implement for your lab.  Don't use this as a reference for what
  //   to do...
  
  // Meta-control
  reg [1:0] PS,PSNext;
  reg PC_EN;
  reg HALT;

  always @(posedge CLK) begin
    if(RESET) begin
      PS <= 2'b00;
    end
    else begin
      PS <= PSNext;
    end
  end

  always @(*) begin
    case(PS)
      2'b00: begin
        if(~EN_L) PSNext <= 2'b10; 
        else PSNext <= 2'b00;
      end
      2'b01: begin
        if(EN_L) PSNext <= 2'b00;
        else PSNext <= 2'b01;
      end
      2'b10: begin
        if(HALT) PSNext <= 2'b01;
        else PSNext <= 2'b10;
      end
      default: PSNext <= 2'b00;
    endcase
  end

  always @(*) begin
    case (PS)
      2'b00 : PC_EN = 0;
      2'b01 : PC_EN = 0;    // change to 1 for enable on negative transition
      2'b10 : PC_EN = 1;
      default : PC_EN = 0;
    endcase
  end

  // the $monitor command outputs a message any time the value of one of
  //   its arguments changes (aside from the $time variable)
  initial begin
    $monitor("MSIM> PC_EN = %1d at time = %1d (ignore until Part C)\nMSIM> ", PC_EN, $time);
  end

  reg [3:0] OP;
  reg [5:0] imm;
  reg [2:0] rs, rt, rd, dr;
  reg [2:0] FUNCT;
  reg [7:0] off;

  reg [7:0] sreg[0:7];    // shadow reg file
  reg [7:0] sdmem[0:255]; // shadow data mem
  reg [7:0] sDataA, sDataB, sDataC, sDataD; // shadow busses
  integer i;

  initial begin
    for(i=0; i<8; i=i+1) begin
       sreg[i] = 0;
    end
  end

  always @(negedge CLK) begin
    OP    = Iin[15:12];
    rs    = Iin[11:9];
    rt    = Iin[8:6];
    rd    = Iin[5:3];
    imm   = Iin[5:0];
    FUNCT = Iin[2:0];
    off   = (imm < 32) ? imm << 1 : (imm - 6'd64) << 1;
    HALT  = 0;

    if(PC_EN || (~RESET && PSNext == 2'b10)) begin
      case (OP)
        4'b0000: begin
          case(FUNCT)
            3'b000: $display("MSIM> PC = %3d: NOP", PC);
            3'b001: begin
              $display("MSIM> PC = %3d: HALT", PC);
              HALT = 1;
            end
            default: $display("MSIM> PC = %3d: Unused instruction %h", PC, Iin);
          endcase
        end
        4'b0010: begin 
          $display("MSIM> PC = %3d: LB   R%1d, %3d(R%1d)", PC, rt, imm, rs); 
          sDataA   = sreg[rs];
          sDataD   = sreg[rs] + {imm[5], imm[5], imm[5:0]};
          sreg[rt] = read_mem(DataD);
          sDataC   = sreg[rt];
        end
        4'b0100: begin 
          $display("MSIM> PC = %3d: SB   R%1d, %3d(R%1d)", PC, rt, imm, rs); 
          sDataA = sreg[rs];
          sDataB = sreg[rt];
          sDataD = sreg[rs] + {imm[5], imm[5], imm[5:0]};
          write_mem(DataD, DataB);
        end
        4'b0101: begin 
          $display("MSIM> PC = %3d: ADDI R%1d, R%1d, %3d", PC, rt, rs, imm);
          sDataA   = sreg[rs]; 
          sreg[rt] = sreg[rs] + {imm[5], imm[5], imm[5:0]};
          sDataC   = sreg[rt];
          check_imm(sDataA, sDataC, DataA, DataC);
        end
        4'b0110: begin 
          $display("MSIM> PC = %3d: ANDI  R%1d,R%1d,%3d", PC, rt, rs, imm); 
          sDataA   = sreg[rs]; 
          sreg[rt] = sreg[rs] & {imm[5], imm[5], imm[5:0]};
          sDataC   = sreg[rt];
          check_imm(sDataA, sDataC, DataA, DataC);
        end
        4'b0111: begin 
          $display("MSIM> PC = %3d: ORI  R%1d, R%1d, %3d", PC, rt, rs, imm); 
          sDataA   = sreg[rs]; 
          sreg[rt] = sreg[rs] | {imm[5], imm[5], imm[5:0]};
          sDataC   = sreg[rt];
          check_imm(sDataA, sDataC, DataA, DataC);
        end
        4'b1000: begin 
          $display("MSIM> PC = %3d: BEQ  R%1d, R%1d, %3d", PC, rs, rt, PC + 8'd2 + off); 
          sDataA = sreg[rs];
          sDataB = sreg[rt];
          check_branch(sDataA, sDataB, DataA, DataB);
          if(DataA == DataB) begin
            if(NextPC != (PC + 8'd2 + off)) begin
              $display("MSIM> ERROR: Incorrect branch target %3d, expected %3d", NextPC, PC + 8'd2 + off);
            end
          end
          else begin
            if(NextPC != PC + 8'd2)begin
              $display("MSIM> ERROR: Incorrect branch target %3d, expected %3d", NextPC, PC + 8'd2);
            end
          end
        end
        4'b1001: begin 
          $display("MSIM> PC = %3d: BNE  R%1d, R%1d, %3d", PC, rs, rt, PC + 8'd2 + off); 
          sDataA = sreg[rs];
          sDataB = sreg[rt];
          check_branch(sDataA, sDataB, DataA, DataB);
          if(DataA != DataB) begin
            if(NextPC != (PC + 8'd2 + off)) begin
              $display("MSIM> ERROR: Incorrect branch target %3d, expected %3d", NextPC, PC + 8'd2 + off);
            end
          end
          else begin
            if(NextPC != PC + 8'd2)begin
              $display("MSIM> ERROR: Incorrect branch target %3d, expected %3d", NextPC, PC + 8'd2);
            end
          end
        end
        4'b1010: begin
          $display("MSIM> PC = %3d: BGEZ R%1d, %3d", PC, rs, PC + 8'd2 + off); 
          sDataA = sreg[rs];
          sDataB = sreg[rt];
          check_branch(sDataA,sDataB,DataA,sDataB); // ignore DataB value
          if(DataA[7] == 1'b0) begin
            if(NextPC != (PC + 8'd2 + off)) begin
              $display("MSIM> ERROR: Incorrect branch target %3d, expected %3d", NextPC, PC + 8'd2 + off);
            end
          end
          else begin
            if(NextPC != PC + 8'd2)begin
              $display("MSIM> ERROR: Incorrect branch target %3d, expected %3d", NextPC, PC + 8'd2);
            end
          end
        end
        4'b1011: begin 
          $display("MSIM> PC = %3d: BLTZ R%1d, %3d", PC, rs, PC + 8'd2 + off); 
          sDataA = sreg[rs];
          sDataB = sreg[rt];                    
          check_branch(sDataA, sDataB, DataA, sDataB); // ignore DataB value
          if(DataA[7] == 1'b1) begin
            if(NextPC != (PC + 8'd2 + off)) begin
              $display("MSIM> ERROR: Incorrect branch target %3d, expected %3d", NextPC, PC + 8'd2 + off);
            end
          end
          else begin
            if(NextPC != PC + 8'd2)begin
              $display("MSIM> ERROR: Incorrect branch target %3d, expected %3d", NextPC, PC + 8'd2);
            end
          end
        end
        4'b1111: begin
          case(FUNCT)
            3'b000: begin 
              $display("MSIM> PC = %3d: ADD  R%1d, R%1d, R%1d", PC, rd, rs, rt); 
              sDataA   = sreg[rs];
              sDataB   = sreg[rt];
              sreg[rd] = sreg[rs] + sreg[rt];
              sDataC   = sreg[rd];
              check_reg2reg(sDataA, sDataB, sDataC, DataA, DataB, DataC);
            end
            3'b001: begin 
              $display("MSIM> PC = %3d: SUB  R%1d, R%1d, R%1d", PC, rd, rs, rt); 
              sDataA   = sreg[rs];
              sDataB   = sreg[rt];
              sreg[rd] = sreg[rs] - sreg[rt];
              sDataC   = sreg[rd];
              check_reg2reg(sDataA, sDataB, sDataC, DataA, DataB, DataC);
            end
            3'b010: begin 
              $display("MSIM> PC = %3d: SRA  R%1d, R%1d", PC, rd, rs); 
              sDataA   = sreg[rs];
              sDataB   = sreg[rt];
              sreg[rd] = {sreg[rs][7],sreg[rs][7:1]};
              sDataC = sreg[rd];
              check_reg2reg(sDataA,sDataB,sDataC,DataA,DataB,DataC);
            end
            3'b011: begin 
              $display("MSIM> PC = %3d: SRL  R%1d, R%1d", PC, rd, rs); 
              sDataA   = sreg[rs];
              sDataB   = sreg[rt];
              sreg[rd] = {1'b0, sreg[rs][7:1]};
              sDataC   = sreg[rd];
              check_reg2reg(sDataA, sDataB, sDataC, DataA, DataB, DataC);
            end
            3'b100: begin 
              $display("MSIM> PC = %3d: SLL  R%1d, R%1d, R%1d", PC, rd, rs, rt); 
              sDataA   = sreg[rs];
              sDataB   = sreg[rt];        
              sreg[rd] = {sreg[rs][6:0], 1'b0};
              sDataC   = sreg[rd];
              check_reg2reg(sDataA, sDataB, sDataC, DataA, DataB, DataC);
            end
            3'b101: begin
              $display("MSIM> PC = %3d: AND  R%1d, R%1d, R%1d", PC, rd, rs, rt);
              sDataA   = sreg[rs];
              sDataB   = sreg[rt];        
              sreg[rd] = sreg[rs] & sreg[rt];
              sDataC   = sreg[rd];
              check_reg2reg(sDataA, sDataB, sDataC, DataA, DataB, DataC);
            end
            3'b110: begin          
              $display("MSIM> PC = %3d: OR   R%1d, R%1d, R%1d", PC, rd, rs, rt);
              sDataA   = sreg[rs];
              sDataB   = sreg[rt];    
              sreg[rd] = sreg[rs] | sreg[rt];
              sDataC   = sreg[rd];
              check_reg2reg(sDataA, sDataB, sDataC, DataA, DataB, DataC);
            end
            default: $display("MSIM> PC = %3d: Unused instruction %h", PC, Iin);
          endcase
        end
        default: $display("MSIM> PC = %3d: Unused instruction %h", PC, Iin);
    endcase

    if(PC == finalPC) begin
        $finish;
    end

    $display("MSIM> ");

    end
  end
  
  
  // TASKS AND FUNCTIONS: helpers to assist with checking the correct values
  
  task check_reg2reg (input [7:0] ss, st, sd, dataa, datab, datac);
    begin
      if(`CHECK) begin   
        if(ss != dataa) begin
          $display("MSIM> ERROR: Source Reg RS = %3d, expecting %3d", dataa, ss);
        end
        if(st != datab) begin
          $display("MSIM> ERROR: Source Reg RT = %3d, expecting %3d", datab, st);
        end
        if(sd != datac) begin
          $display("MSIM> ERROR: Dest Reg RD = %3d, expecting %3d", datac, sd);
        end
      end
    end
  endtask

  
  task check_imm (input [7:0] ss, st, dataa, datac);
    begin
      if(`CHECK) begin
        if(ss !== dataa) begin
          $display("MSIM> ERROR: Source Reg RS = %3d, expecting %3d", dataa, ss);
        end
        if(st !== datac) begin
          $display("MSIM> ERROR: Dest Reg RT = %3d, expecting %3d", datac, st);
        end
      end
    end
  endtask

  
  task check_branch (input [7:0] ss, st, dataa, datab);
    begin
      if(`CHECK) begin   
        if(ss !== dataa) $display("MSIM> ERROR: Source Reg RS = %3d, expecting %3d", dataa, ss);
        if(st !== datab) $display("MSIM> ERROR: Source Reg RT = %3d, expecting %3d", datab, st);
      end
    end
  endtask

  
  task write_mem(input [7:0] DataD, DataB);
    begin
      casex(sDataD)
        8'd248: $display("MSIM> ERROR: Address %3d is READ ONLY", DataD);
        8'd249: $display("MSIM> ERROR: Address %3d is READ ONLY", DataD);
        8'd250: $display("MSIM> Output on IOC of %2h", DataB);
        8'd251: $display("MSIM> Output on IOD of %2h", DataB);
        8'd252: $display("MSIM> Output on IOE of %2h", DataB);
        8'd253: $display("MSIM> Output on IOF of %2h", DataB);
        8'd254: $display("MSIM> Output on IOG of %2h", DataB);
        8'd255: $display("MSIM> Output on IOH of %2h", DataB);
        default: begin // regular memory
          if(WE) begin
            sdmem[DataD] = DataB;
          end
        end
      endcase
    end
  endtask

  
  function [7:0] read_mem(input [7:0] DataD);
    begin
      if(DataD === 8'd248) begin
        read_mem = IOA;
        $display("MSIM> INPUT on IOA of %2h", IOA);
      end
      else if(DataD === 8'd249) begin
        read_mem = IOB;
        $display("MSIM> INPUT on IOB of %2h", IOB);
      end
      else begin
        read_mem = sdmem[DataD];
      end
    end
  endfunction

endmodule
