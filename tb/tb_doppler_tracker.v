`timescale 1ns/1ps
module tb_doppler_tracker;
reg clk=0;always #5 clk=~clk;
reg rst_n=0,sample_valid=0;
reg signed [11:0] sample_i=0,sample_q=0;
wire estimate_valid; wire signed [24:0] phase_metric,filtered_metric;
doppler_tracker dut(clk,rst_n,sample_valid,sample_i,sample_q,estimate_valid,phase_metric,filtered_metric);
integer n=0;
initial begin
 repeat(3) @(negedge clk);rst_n=1;
 // Each sample rotates 90 degrees: positive cross product of magnitude 10000.
 @(negedge clk);sample_valid=1;sample_i=100;sample_q=0;
 @(negedge clk);sample_i=0;sample_q=100;
 @(negedge clk);sample_i=-100;sample_q=0;
 @(negedge clk);sample_i=0;sample_q=-100;
 @(negedge clk);sample_valid=0;
 @(negedge clk);
 if(n!==3) $fatal(1,"expected 3 valid estimates, got %0d",n);
 if(phase_metric!==25'sd10000) $fatal(1,"unexpected metric %0d",phase_metric);
 if(filtered_metric<=0) $fatal(1,"filtered result should be positive");
 $display("PASS tracker discriminator %0d filter %0d",phase_metric,filtered_metric);$finish;
end
always @(negedge clk) if(estimate_valid) n=n+1;
initial begin #2000;$fatal(1,"timeout");end
endmodule
