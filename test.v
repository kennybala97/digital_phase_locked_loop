module test;
   reg A;
   wire Y;
   not x(Y,A);
   initial begin
      $dumpvars(0,test);
      #10;
      A=0;
      #10;
      A=1;
      #10;
   end
endmodule