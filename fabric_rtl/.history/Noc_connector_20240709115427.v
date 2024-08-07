/*
    created by: <Xidian University>
    created date: 2024-05-16
*/

`include "Noc_parameters.v"

module Noc_connector
(
    input                           noc_clk,
    input                           noc_rst_n,

    input   [0:0]                   Noc_0_0_receive_valid,
    output  [0:0]                   Noc_0_0_receive_ready,
    input   [`Noc_Data_Width-1:0]   Noc_0_0_receive_flit,
    input   [0:0]                   Noc_0_0_receive_is_header,
    input   [0:0]                   Noc_0_0_receive_is_tail,
    
    output  [0:0]                   Noc_0_0_sender_valid,
    input   [0:0]                   Noc_0_0_sender_ready,
    output  [`Noc_Data_Width-1:0]   Noc_0_0_sender_flit,
    input   [0:0]                   Noc_0_0_sender_VCready,
    output  [0:0]                   Noc_0_0_sender_is_header,
    output  [0:0]                   Noc_0_0_sender_is_tail,

    input   [0:0]                   Noc_0_1_receive_valid,
    output  [0:0]                   Noc_0_1_receive_ready,
    input   [`Noc_Data_Width-1:0]   Noc_0_1_receive_flit,
    input   [0:0]                   Noc_0_1_receive_is_header,
    input   [0:0]                   Noc_0_1_receive_is_tail,
    
    output  [0:0]                   Noc_0_1_sender_valid,
    input   [0:0]                   Noc_0_1_sender_ready,
    output  [`Noc_Data_Width-1:0]   Noc_0_1_sender_flit,
    input   [0:0]                   Noc_0_1_sender_VCready,
    output  [0:0]                   Noc_0_1_sender_is_header,
    output  [0:0]                   Noc_0_1_sender_is_tail,

    input   [0:0]                   Noc_1_0_receive_valid,
    output  [0:0]                   Noc_1_0_receive_ready,
    input   [`Noc_Data_Width-1:0]   Noc_1_0_receive_flit,
    input   [0:0]                   Noc_1_0_receive_is_header,
    input   [0:0]                   Noc_1_0_receive_is_tail,
    
    output  [0:0]                   Noc_1_0_sender_valid,
    input   [0:0]                   Noc_1_0_sender_ready,
    output  [`Noc_Data_Width-1:0]   Noc_1_0_sender_flit,
    input   [0:0]                   Noc_1_0_sender_VCready,
    output  [0:0]                   Noc_1_0_sender_is_header,
    output  [0:0]                   Noc_1_0_sender_is_tail,

    input   [0:0]                   Noc_1_1_receive_valid,
    output  [0:0]                   Noc_1_1_receive_ready,
    input   [`Noc_Data_Width-1:0]   Noc_1_1_receive_flit,
    input   [0:0]                   Noc_1_1_receive_is_header,
    input   [0:0]                   Noc_1_1_receive_is_tail,
    
    output  [0:0]                   Noc_1_1_sender_valid,
    input   [0:0]                   Noc_1_1_sender_ready,
    output  [`Noc_Data_Width-1:0]   Noc_1_1_sender_flit,
    input   [0:0]                   Noc_1_1_sender_VCready,
    output  [0:0]                   Noc_1_1_sender_is_header,
    output  [0:0]                   Noc_1_1_sender_is_tail
);    
wire  [0:0]                   Noc_0_0_channel0_receive_valid;            
wire  [0:0]                   Noc_0_0_channel0_receive_ready;            
wire  [`Noc_Data_Width-1:0]   Noc_0_0_channel0_receive_flit;             
wire  [0:0]                   Noc_0_0_channel0_receive_VCready;          
wire  [0:0]                   Noc_0_0_channel0_receive_is_header;        
wire  [0:0]                   Noc_0_0_channel0_receive_is_tail;          
    
wire  [0:0]                   Noc_0_0_channel1_receive_valid;            
wire  [0:0]                   Noc_0_0_channel1_receive_ready;            
wire  [`Noc_Data_Width-1:0]   Noc_0_0_channel1_receive_flit;             
wire  [0:0]                   Noc_0_0_channel1_receive_VCready;          
wire  [0:0]                   Noc_0_0_channel1_receive_is_header;        
wire  [0:0]                   Noc_0_0_channel1_receive_is_tail;          
    
wire  [0:0]                   Noc_0_1_channel0_receive_valid;            
wire  [0:0]                   Noc_0_1_channel0_receive_ready;            
wire  [`Noc_Data_Width-1:0]   Noc_0_1_channel0_receive_flit;             
wire  [0:0]                   Noc_0_1_channel0_receive_VCready;          
wire  [0:0]                   Noc_0_1_channel0_receive_is_header;        
wire  [0:0]                   Noc_0_1_channel0_receive_is_tail;          
    
wire  [0:0]                   Noc_0_1_channel1_receive_valid;            
wire  [0:0]                   Noc_0_1_channel1_receive_ready;            
wire  [`Noc_Data_Width-1:0]   Noc_0_1_channel1_receive_flit;             
wire  [0:0]                   Noc_0_1_channel1_receive_VCready;          
wire  [0:0]                   Noc_0_1_channel1_receive_is_header;        
wire  [0:0]                   Noc_0_1_channel1_receive_is_tail;          
    
wire  [0:0]                   Noc_1_0_channel0_receive_valid;            
wire  [0:0]                   Noc_1_0_channel0_receive_ready;            
wire  [`Noc_Data_Width-1:0]   Noc_1_0_channel0_receive_flit;             
wire  [0:0]                   Noc_1_0_channel0_receive_VCready;          
wire  [0:0]                   Noc_1_0_channel0_receive_is_header;        
wire  [0:0]                   Noc_1_0_channel0_receive_is_tail;          
    
wire  [0:0]                   Noc_1_0_channel1_receive_valid;            
wire  [0:0]                   Noc_1_0_channel1_receive_ready;            
wire  [`Noc_Data_Width-1:0]   Noc_1_0_channel1_receive_flit;             
wire  [0:0]                   Noc_1_0_channel1_receive_VCready;          
wire  [0:0]                   Noc_1_0_channel1_receive_is_header;        
wire  [0:0]                   Noc_1_0_channel1_receive_is_tail;          
    
wire  [0:0]                   Noc_1_1_channel0_receive_valid;            
wire  [0:0]                   Noc_1_1_channel0_receive_ready;            
wire  [`Noc_Data_Width-1:0]   Noc_1_1_channel0_receive_flit;             
wire  [0:0]                   Noc_1_1_channel0_receive_VCready;          
wire  [0:0]                   Noc_1_1_channel0_receive_is_header;        
wire  [0:0]                   Noc_1_1_channel0_receive_is_tail;          
    
wire  [0:0]                   Noc_1_1_channel1_receive_valid;            
wire  [0:0]                   Noc_1_1_channel1_receive_ready;            
wire  [`Noc_Data_Width-1:0]   Noc_1_1_channel1_receive_flit;             
wire  [0:0]                   Noc_1_1_channel1_receive_VCready;          
wire  [0:0]                   Noc_1_1_channel1_receive_is_header;        
wire  [0:0]                   Noc_1_1_channel1_receive_is_tail;          



Noc_bridge Noc_bridge_0_0_instance(
    .noc_clk                                  (noc_clk),
    .noc_rst_n                                (noc_rst_n),
    .Noc_receive_valid                        (Noc_0_0_receive_valid),
    .Noc_receive_ready                        (Noc_0_0_receive_ready),
    .Noc_receive_flit                         (Noc_0_0_receive_flit),
    .Noc_receive_is_header                    (Noc_0_0_receive_is_header),
    .Noc_receive_is_tail                      (Noc_0_0_receive_is_tail),
        
    .Noc_channel0_sender_valid                (Noc_0_0_channel0_receive_valid),
    .Noc_channel0_sender_ready                (Noc_0_0_channel0_receive_ready),
    .Noc_channel0_sender_flit                 (Noc_0_0_channel0_receive_flit),
    .Noc_channel0_sender_VCready              (Noc_0_0_channel0_receive_VCready),
    .Noc_channel0_sender_is_header            (Noc_0_0_channel0_receive_is_header),
    .Noc_channel0_sender_is_tail              (Noc_0_0_channel0_receive_is_tail),
    
    .Noc_channel1_sender_valid                (Noc_0_0_channel1_receive_valid),
    .Noc_channel1_sender_ready                (Noc_0_0_channel1_receive_ready),
    .Noc_channel1_sender_flit                 (Noc_0_0_channel1_receive_flit),
    .Noc_channel1_sender_VCready              (Noc_0_0_channel1_receive_VCready),
    .Noc_channel1_sender_is_header            (Noc_0_0_channel1_receive_is_header),
    .Noc_channel1_sender_is_tail              (Noc_0_0_channel1_receive_is_tail)
);


Noc_bridge Noc_bridge_0_1_instance(
    .noc_clk                                  (noc_clk),
    .noc_rst_n                                (noc_rst_n),
    .Noc_receive_valid                        (Noc_0_1_receive_valid),
    .Noc_receive_ready                        (Noc_0_1_receive_ready),
    .Noc_receive_flit                         (Noc_0_1_receive_flit),
    .Noc_receive_is_header                    (Noc_0_1_receive_is_header),
    .Noc_receive_is_tail                      (Noc_0_1_receive_is_tail),
        
    .Noc_channel0_sender_valid                (Noc_0_1_channel0_receive_valid),
    .Noc_channel0_sender_ready                (Noc_0_1_channel0_receive_ready),
    .Noc_channel0_sender_flit                 (Noc_0_1_channel0_receive_flit),
    .Noc_channel0_sender_VCready              (Noc_0_1_channel0_receive_VCready),
    .Noc_channel0_sender_is_header            (Noc_0_1_channel0_receive_is_header),
    .Noc_channel0_sender_is_tail              (Noc_0_1_channel0_receive_is_tail),
    
    .Noc_channel1_sender_valid                (Noc_0_1_channel1_receive_valid),
    .Noc_channel1_sender_ready                (Noc_0_1_channel1_receive_ready),
    .Noc_channel1_sender_flit                 (Noc_0_1_channel1_receive_flit),
    .Noc_channel1_sender_VCready              (Noc_0_1_channel1_receive_VCready),
    .Noc_channel1_sender_is_header            (Noc_0_1_channel1_receive_is_header),
    .Noc_channel1_sender_is_tail              (Noc_0_1_channel1_receive_is_tail)
);


Noc_bridge Noc_bridge_1_0_instance(
    .noc_clk                                  (noc_clk),
    .noc_rst_n                                (noc_rst_n),
    .Noc_receive_valid                        (Noc_1_0_receive_valid),
    .Noc_receive_ready                        (Noc_1_0_receive_ready),
    .Noc_receive_flit                         (Noc_1_0_receive_flit),
    .Noc_receive_is_header                    (Noc_1_0_receive_is_header),
    .Noc_receive_is_tail                      (Noc_1_0_receive_is_tail),
        
    .Noc_channel0_sender_valid                (Noc_1_0_channel0_receive_valid),
    .Noc_channel0_sender_ready                (Noc_1_0_channel0_receive_ready),
    .Noc_channel0_sender_flit                 (Noc_1_0_channel0_receive_flit),
    .Noc_channel0_sender_VCready              (Noc_1_0_channel0_receive_VCready),
    .Noc_channel0_sender_is_header            (Noc_1_0_channel0_receive_is_header),
    .Noc_channel0_sender_is_tail              (Noc_1_0_channel0_receive_is_tail),
    
    .Noc_channel1_sender_valid                (Noc_1_0_channel1_receive_valid),
    .Noc_channel1_sender_ready                (Noc_1_0_channel1_receive_ready),
    .Noc_channel1_sender_flit                 (Noc_1_0_channel1_receive_flit),
    .Noc_channel1_sender_VCready              (Noc_1_0_channel1_receive_VCready),
    .Noc_channel1_sender_is_header            (Noc_1_0_channel1_receive_is_header),
    .Noc_channel1_sender_is_tail              (Noc_1_0_channel1_receive_is_tail)
);


Noc_bridge Noc_bridge_1_1_instance(
    .noc_clk                                  (noc_clk),
    .noc_rst_n                                (noc_rst_n),
    .Noc_receive_valid                        (Noc_1_1_receive_valid),
    .Noc_receive_ready                        (Noc_1_1_receive_ready),
    .Noc_receive_flit                         (Noc_1_1_receive_flit),
    .Noc_receive_is_header                    (Noc_1_1_receive_is_header),
    .Noc_receive_is_tail                      (Noc_1_1_receive_is_tail),
        
    .Noc_channel0_sender_valid                (Noc_1_1_channel0_receive_valid),
    .Noc_channel0_sender_ready                (Noc_1_1_channel0_receive_ready),
    .Noc_channel0_sender_flit                 (Noc_1_1_channel0_receive_flit),
    .Noc_channel0_sender_VCready              (Noc_1_1_channel0_receive_VCready),
    .Noc_channel0_sender_is_header            (Noc_1_1_channel0_receive_is_header),
    .Noc_channel0_sender_is_tail              (Noc_1_1_channel0_receive_is_tail),
    
    .Noc_channel1_sender_valid                (Noc_1_1_channel1_receive_valid),
    .Noc_channel1_sender_ready                (Noc_1_1_channel1_receive_ready),
    .Noc_channel1_sender_flit                 (Noc_1_1_channel1_receive_flit),
    .Noc_channel1_sender_VCready              (Noc_1_1_channel1_receive_VCready),
    .Noc_channel1_sender_is_header            (Noc_1_1_channel1_receive_is_header),
    .Noc_channel1_sender_is_tail              (Noc_1_1_channel1_receive_is_tail)
);


Noc_fabric_verilog_top Noc_fabric_verilog_top_inst(
    .noc_clk                                    (noc_clk),
    .noc_rst_n                                  (noc_rst_n),    
    .Noc_0_0_channel0_receive_valid             (Noc_0_0_channel0_receive_valid),
    .Noc_0_0_channel0_receive_ready             (Noc_0_0_channel0_receive_ready),
    .Noc_0_0_channel0_receive_flit              (Noc_0_0_channel0_receive_flit),
    .Noc_0_0_channel0_receive_VCready           (Noc_0_0_channel0_receive_VCready),
    .Noc_0_0_channel0_receive_is_header         (Noc_0_0_channel0_receive_is_header),
    .Noc_0_0_channel0_receive_is_tail           (Noc_0_0_channel0_receive_is_tail),
    
    .Noc_0_0_channel1_receive_valid             (Noc_0_0_channel1_receive_valid),
    .Noc_0_0_channel1_receive_ready             (Noc_0_0_channel1_receive_ready),
    .Noc_0_0_channel1_receive_flit              (Noc_0_0_channel1_receive_flit),
    .Noc_0_0_channel1_receive_VCready           (Noc_0_0_channel1_receive_VCready),
    .Noc_0_0_channel1_receive_is_header         (Noc_0_0_channel1_receive_is_header),
    .Noc_0_0_channel1_receive_is_tail           (Noc_0_0_channel1_receive_is_tail),

    .Noc_0_0_sender_valid                       (Noc_0_0_sender_valid),
    .Noc_0_0_sender_ready                       (Noc_0_0_sender_ready),
    .Noc_0_0_sender_flit                        (Noc_0_0_sender_flit),
    .Noc_0_0_sender_VCready                     (Noc_0_0_sender_VCready),
    .Noc_0_0_sender_is_header                   (Noc_0_0_sender_is_header),
    .Noc_0_0_sender_is_tail                     (Noc_0_0_sender_is_tail),
    
    .Noc_0_1_channel0_receive_valid             (Noc_0_1_channel0_receive_valid),
    .Noc_0_1_channel0_receive_ready             (Noc_0_1_channel0_receive_ready),
    .Noc_0_1_channel0_receive_flit              (Noc_0_1_channel0_receive_flit),
    .Noc_0_1_channel0_receive_VCready           (Noc_0_1_channel0_receive_VCready),
    .Noc_0_1_channel0_receive_is_header         (Noc_0_1_channel0_receive_is_header),
    .Noc_0_1_channel0_receive_is_tail           (Noc_0_1_channel0_receive_is_tail),
    
    .Noc_0_1_channel1_receive_valid             (Noc_0_1_channel1_receive_valid),
    .Noc_0_1_channel1_receive_ready             (Noc_0_1_channel1_receive_ready),
    .Noc_0_1_channel1_receive_flit              (Noc_0_1_channel1_receive_flit),
    .Noc_0_1_channel1_receive_VCready           (Noc_0_1_channel1_receive_VCready),
    .Noc_0_1_channel1_receive_is_header         (Noc_0_1_channel1_receive_is_header),
    .Noc_0_1_channel1_receive_is_tail           (Noc_0_1_channel1_receive_is_tail),

    .Noc_0_1_sender_valid                       (Noc_0_1_sender_valid),
    .Noc_0_1_sender_ready                       (Noc_0_1_sender_ready),
    .Noc_0_1_sender_flit                        (Noc_0_1_sender_flit),
    .Noc_0_1_sender_VCready                     (Noc_0_1_sender_VCready),
    .Noc_0_1_sender_is_header                   (Noc_0_1_sender_is_header),
    .Noc_0_1_sender_is_tail                     (Noc_0_1_sender_is_tail),
    
    .Noc_1_0_channel0_receive_valid             (Noc_1_0_channel0_receive_valid),
    .Noc_1_0_channel0_receive_ready             (Noc_1_0_channel0_receive_ready),
    .Noc_1_0_channel0_receive_flit              (Noc_1_0_channel0_receive_flit),
    .Noc_1_0_channel0_receive_VCready           (Noc_1_0_channel0_receive_VCready),
    .Noc_1_0_channel0_receive_is_header         (Noc_1_0_channel0_receive_is_header),
    .Noc_1_0_channel0_receive_is_tail           (Noc_1_0_channel0_receive_is_tail),
    
    .Noc_1_0_channel1_receive_valid             (Noc_1_0_channel1_receive_valid),
    .Noc_1_0_channel1_receive_ready             (Noc_1_0_channel1_receive_ready),
    .Noc_1_0_channel1_receive_flit              (Noc_1_0_channel1_receive_flit),
    .Noc_1_0_channel1_receive_VCready           (Noc_1_0_channel1_receive_VCready),
    .Noc_1_0_channel1_receive_is_header         (Noc_1_0_channel1_receive_is_header),
    .Noc_1_0_channel1_receive_is_tail           (Noc_1_0_channel1_receive_is_tail),

    .Noc_1_0_sender_valid                       (Noc_1_0_sender_valid),
    .Noc_1_0_sender_ready                       (Noc_1_0_sender_ready),
    .Noc_1_0_sender_flit                        (Noc_1_0_sender_flit),
    .Noc_1_0_sender_VCready                     (Noc_1_0_sender_VCready),
    .Noc_1_0_sender_is_header                   (Noc_1_0_sender_is_header),
    .Noc_1_0_sender_is_tail                     (Noc_1_0_sender_is_tail),
    
    .Noc_1_1_channel0_receive_valid             (Noc_1_1_channel0_receive_valid),
    .Noc_1_1_channel0_receive_ready             (Noc_1_1_channel0_receive_ready),
    .Noc_1_1_channel0_receive_flit              (Noc_1_1_channel0_receive_flit),
    .Noc_1_1_channel0_receive_VCready           (Noc_1_1_channel0_receive_VCready),
    .Noc_1_1_channel0_receive_is_header         (Noc_1_1_channel0_receive_is_header),
    .Noc_1_1_channel0_receive_is_tail           (Noc_1_1_channel0_receive_is_tail),
    
    .Noc_1_1_channel1_receive_valid             (Noc_1_1_channel1_receive_valid),
    .Noc_1_1_channel1_receive_ready             (Noc_1_1_channel1_receive_ready),
    .Noc_1_1_channel1_receive_flit              (Noc_1_1_channel1_receive_flit),
    .Noc_1_1_channel1_receive_VCready           (Noc_1_1_channel1_receive_VCready),
    .Noc_1_1_channel1_receive_is_header         (Noc_1_1_channel1_receive_is_header),
    .Noc_1_1_channel1_receive_is_tail           (Noc_1_1_channel1_receive_is_tail),

    .Noc_1_1_sender_valid                       (Noc_1_1_sender_valid),
    .Noc_1_1_sender_ready                       (Noc_1_1_sender_ready),
    .Noc_1_1_sender_flit                        (Noc_1_1_sender_flit),
    .Noc_1_1_sender_VCready                     (Noc_1_1_sender_VCready),
    .Noc_1_1_sender_is_header                   (Noc_1_1_sender_is_header),
    .Noc_1_1_sender_is_tail                     (Noc_1_1_sender_is_tail)
);

endmodule