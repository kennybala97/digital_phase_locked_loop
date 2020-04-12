module clock_divider(clk,reset, clk_out);

   parameter WIDTH = 3;    // Width of the register required
   parameter N = 6;   // We will divide by 12 for example in this case


   input clk;
   input reset;
   output clk_out;

   reg [WIDTH-1:0] r_reg = 0;
   wire [WIDTH-1:0] r_nxt;
   reg clk_track = 0;

   always @(posedge clk or posedge reset) begin
      if (~reset) begin
         r_reg <= 0;
         clk_track <= 1'b0;
      end else if (r_nxt == N) begin
         r_reg <= 0;
         clk_track <= ~clk_track;
      end else begin
         r_reg <= r_nxt;
      end

   end

   assign r_nxt = r_reg+1;
   assign clk_out = clk_track;
endmodule
