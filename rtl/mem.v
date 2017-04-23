module mem #(
  parameter   WIDTH_SIZE      = 256,
  parameter   NUM_WORDS_WIDTH = 8
) (
  input                           clock,
  input                           aclr,

  input  [NUM_WORDS_WIDTH - 1:0]  address_a,
  input  [WIDTH_SIZE - 1:0]       data_a,
  input                           wren_a,
  input                           rden_a,
  output [WIDTH_SIZE - 1:0]       q_a,

  input  [NUM_WORDS_WIDTH - 1:0]  address_b,
  input  [WIDTH_SIZE - 1:0]       data_b,
  input                           wren_b,
  input                           rden_b,
  output [WIDTH_SIZE - 1:0]       q_b
);

localparam NUM_WORDS_SIZE  = 1 << NUM_WORDS_WIDTH;

altsyncram altsyncram_component (
    .clock0         ( clock              ),
    .aclr0          ( aclr               ),
    
    .clock1         ( 1'b1               ),
    .aclr1          ( 1'b0               ),

    .address_a      ( address_a          ),
    .wren_a         ( wren_a             ),
    .rden_a         ( rden_a             ),
    .data_a         ( data_a             ),
    .q_a            ( q_a                ),
    
    .address_b      ( address_b          ),
    .wren_b         ( wren_b             ),
    .rden_b         ( rden_b             ),
    .data_b         ( data_b             ),
    .q_b            ( q_b                ),

    .addressstall_a ( 1'b0               ),
    .addressstall_b ( 1'b0               ),
    .byteena_a      ( 1'b1               ),
    .byteena_b      ( 1'b1               ),
    .clocken0       ( 1'b1               ),
    .clocken1       ( 1'b1               ),
    .clocken2       ( 1'b1               ),
    .clocken3       ( 1'b1               ),
    .eccstatus      (                    )
);

defparam
    altsyncram_component.address_reg_b                      = "CLOCK0",
    altsyncram_component.clock_enable_input_a               = "BYPASS",
    altsyncram_component.clock_enable_input_b               = "BYPASS",
    altsyncram_component.clock_enable_output_a              = "BYPASS",
    altsyncram_component.clock_enable_output_b              = "BYPASS",
    altsyncram_component.indata_reg_b                       = "CLOCK0",
    altsyncram_component.init_file                          = "UNUSED",
    altsyncram_component.intended_device_family             = "Stratix V",
    altsyncram_component.lpm_type                           = "altsyncram",
    altsyncram_component.numwords_a                         = NUM_WORDS_SIZE,
    altsyncram_component.numwords_b                         = NUM_WORDS_SIZE,
    altsyncram_component.operation_mode                     = "DUAL_PORT",
    altsyncram_component.outdata_aclr_a                     = "CLEAR0",
    altsyncram_component.outdata_aclr_b                     = "CLEAR0",
    altsyncram_component.outdata_reg_a                      = "UNREGISTERED",
    altsyncram_component.outdata_reg_b                      = "UNREGISTERED",
    altsyncram_component.power_up_uninitialized             = "FALSE",
  //altsyncram_component.read_during_write_mode_mixed_ports = "OLD_DATA",
    altsyncram_component.read_during_write_mode_mixed_ports = "DONT_CARE",
    altsyncram_component.read_during_write_mode_port_a      = "NEW_DATA_NO_NBE_READ",
    altsyncram_component.read_during_write_mode_port_b      = "NEW_DATA_NO_NBE_READ",
    altsyncram_component.widthad_a                          = NUM_WORDS_WIDTH,
    altsyncram_component.widthad_b                          = NUM_WORDS_WIDTH,
    altsyncram_component.width_a                            = WIDTH_SIZE,
    altsyncram_component.width_b                            = WIDTH_SIZE,
    altsyncram_component.width_byteena_a                    = 1,
    altsyncram_component.width_byteena_b                    = 1,
    altsyncram_component.wrcontrol_wraddress_reg_b          = "CLOCK0",
    altsyncram_component.rdcontrol_reg_b                    = "CLOCK0";


endmodule
