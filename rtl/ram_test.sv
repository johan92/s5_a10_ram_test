module ram_test #(
  parameter RAM_ADDR_W = 8,
  parameter CHUNK_W    = 32,
  parameter CHUNK_CNT  = 4,
  parameter MAGIC      = 0
) (
  input clk_i,
  input rst_i

);

logic [CHUNK_CNT-1:0][CHUNK_W-1:0] wr_data;
logic [CHUNK_CNT-1:0][CHUNK_W-1:0] rd_data;

logic [RAM_ADDR_W-1:0]             wr_addr;
logic [RAM_ADDR_W-1:0]             rd_addr;

mem #(
  .WIDTH_SIZE                             ( $bits(wr_data)    ),
  .NUM_WORDS_WIDTH                        ( RAM_ADDR_W        )
) mem (
  .clock                                  ( clk_i             ),
  .aclr                                   ( 1'b0              ),

  // read port 
  .address_b                              ( rd_addr           ),
  .data_b                                 (                   ),
  .wren_b                                 ( 1'b0              ),
  .rden_b                                 ( 1'b1              ),
  .q_b                                    ( rd_data           ),
  
  // write port
  .address_a                              ( wr_addr           ),
  .data_a                                 ( wr_data           ),
  .wren_a                                 ( 1'b1              ),
  .rden_a                                 ( 1'b0              ),
  .q_a                                    (                   )
);

always_ff @( posedge clk_i or posedge rst_i )
  if( rst_i )
    rd_addr <= MAGIC;
  else
    rd_addr <= rd_addr + 1'd1;

always_ff @( posedge clk_i )
  wr_addr <= rd_addr;

genvar g;
generate
  for( g = 0; g < CHUNK_CNT; g++ ) begin : g_logic
    assign wr_data[g] = rd_data[g] + wr_addr + MAGIC;
  end
endgenerate

logic [CHUNK_CNT*CHUNK_W-1:0] rd_data_w;
logic                         dummy_reg /* synthesis noprune */;

assign rd_data_w = rd_data;

always_ff @( posedge clk_i )
  dummy_reg <= ^rd_data_w;

endmodule
