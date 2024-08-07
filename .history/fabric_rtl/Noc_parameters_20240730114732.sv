/*
    created by: <Xidian University>
    created date: 2024-05-16
*/

`timescale 1ns/1ps

`ifndef NOC_PARAMETER_SV
`define NOC_PARAMETER_SV

`include "Noc_parameters.v"

package Noc_parameters;
    localparam bit                      Noc_Node_Active         = `Noc_Node_Active;
    localparam int                      Noc_Flit_Width          = `Noc_Flit_Width;
    localparam int                      Noc_Data_Width          = `Noc_Data_Width;
    localparam int                      Noc_X_Size              = `Noc_X_Size;
    localparam int                      Noc_Y_Size              = `Noc_Y_Size;
    localparam int                      Noc_VC_Channel          = `Noc_VC_Channel;
    localparam int                      Noc_VC_Fifo_Depth       = `Noc_VC_Fifo_Depth;
    localparam int                      Noc_Node_Num            = `Noc_Node_Num;
    localparam int                      Noc_ID_X_Width          = `Noc_ID_X_Width;
    localparam int                      Noc_ID_Y_Width          = `Noc_ID_Y_Width;
    localparam int                      Noc_Head_Bit            = `Noc_Head_Bit;
    localparam bit [Noc_Head_Bit-1:0]   Noc_Head_H              = `Noc_Head_H;
    localparam bit [Noc_Head_Bit-1:0]   Noc_Head_E              = `Noc_Head_E;
    localparam bit [Noc_Head_Bit-1:0]   Noc_Tail_H              = `Noc_Tail_H;
    localparam bit [Noc_Head_Bit-1:0]   Noc_Tail_E              = `Noc_Tail_E;
    localparam int                      Noc_Point_H             = `Noc_Point_H;
    localparam int                      Noc_Source_Point        = `Noc_Source_Point;
    localparam int                      Noc_Dest_Point          = `Noc_Dest_Point;
    localparam int                      Axi_Type_Point          = `Axi_Type_Point;
    localparam int                      Axi_Pack_Order_Point    = `Axi_Pack_Order_Point;
    localparam int                      Axi_Len_Point           = `Axi_Len_Point;
    localparam int                      Noc_Point_E             = `Noc_Point_E;
    localparam int                      Axi_TYPE_Bit            = `Axi_TYPE_Bit;
    localparam int                      Axi_PACK_ORDER_Bit      = `Axi_PACK_ORDER_Bit;
    localparam int                      Axi_LEN_Bit             = `Axi_LEN_Bit;
    localparam int                      Less_Byte               = `Less_Byte;

    typedef enum logic [4:0] {
        ROUTE_EAST  = 5'b00001,
        ROUTE_WEST  = 5'b00010,
        ROUTE_SOUTH = 5'b00100,
        ROUTE_NORTH = 5'b01000,
        ROUTE_LOCAL = 5'b10000,
        ROUTE_NA    = 5'b00000
    } e_route;

    typedef enum logic [0:0] {
        LOCAL     = 1'b0,
        INTERNAL  = 1'b1
    } port_type;
endpackage

`endif