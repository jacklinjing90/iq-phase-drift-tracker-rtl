// Project 2: differential phase discriminator + first-order IIR tracking filter.
// Units: output is an uncalibrated discriminator quantity, NOT Hz.
// This estimates signed phase rotation for small phase steps; no NCO correction here.
module doppler_tracker #(
 parameter integer W=12,
 parameter integer FILTER_SHIFT=3
) (
 input wire clk, rst_n, sample_valid,
 input wire signed [W-1:0] sample_i, sample_q,
 output reg estimate_valid,
 output reg signed [2*W:0] phase_metric,
 output reg signed [2*W:0] filtered_metric
);
 reg signed [W-1:0] old_i, old_q;
 reg have_old;
 wire signed [2*W-1:0] p_iq = $signed(old_i) * $signed(sample_q);
 wire signed [2*W-1:0] p_qi = $signed(old_q) * $signed(sample_i);
 wire signed [2*W:0] diff = $signed({p_iq[2*W-1],p_iq}) - $signed({p_qi[2*W-1],p_qi});
 wire signed [2*W:0] delta = diff - filtered_metric;
 always @(posedge clk or negedge rst_n) begin
  if (!rst_n) begin
   old_i<=0;old_q<=0;have_old<=0;estimate_valid<=0;
   phase_metric<=0;filtered_metric<=0;
  end else begin
   estimate_valid<=0;
   if(sample_valid) begin
    old_i<=sample_i;old_q<=sample_q;
    have_old<=1;
    if(have_old) begin
     phase_metric<=diff;
     filtered_metric<=filtered_metric + (delta >>> FILTER_SHIFT);
     estimate_valid<=1;
    end
   end
  end
 end
endmodule
