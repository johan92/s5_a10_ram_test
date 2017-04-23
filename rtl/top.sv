module top(
  input clk_i,
  input rst_i
);

localparam RAM_ADDR_W = 8;
localparam CHUNK_W    = 32;
localparam CHUNK_CNT  = 1;

genvar g;

generate
  for( g = 0; g < 1; g++ ) begin : g_ram_test_engine
    ram_test #(
      .RAM_ADDR_W           ( RAM_ADDR_W   ),
      .CHUNK_W              ( CHUNK_W      ),
      .CHUNK_CNT            ( CHUNK_CNT    ),
      .MAGIC                ( g            )
    ) ram_test_engine (

      .clk_i                ( clk_i        ),
      .rst_i                ( rst_i        )

    );
  end
endgenerate

endmodule
