/*
    created by: <Xidian University>
    created date: 2024-05-16
*/

`ifndef TNOC_PKG_SV
`define TNOC_PKG_SV

// Self Defined Parameters
`define Noc_Data_Width      128
`define Noc_X_Size          3
`define Noc_Y_Size          3
`define Noc_VC_Channel      4
`define Noc_VC_Fifo_Depth   4

// Auto Calculation
`define Noc_Node_Num    (`Noc_X_Size * `Noc_Y_Size)
`define Noc_ID_X_Width  $clog2(`Noc_X_Size)
`define Noc_ID_Y_Width  $clog2(`Noc_Y_Size)

// Flit Definition (Head, Tail, Data)
`define Noc_Head_Bit            4
`define Axi_TYPE_Bit            3
`define Axi_PACK_ORDER_Bit      8
`define Axi_LEN_Bit             8
`define Noc_Head_H              4'hA
`define Noc_Head_E              4'hB
`define Noc_Tail_H              4'hC
`define Noc_Tail_E              4'hD
`define Noc_Point_H             (`Noc_Data_Width - `Noc_Head_Bit)
`define Noc_Source_Point        (`Noc_Point_H - `Noc_ID_X_Width - `Noc_ID_Y_Width)
`define Noc_Dest_Point          (`Noc_Source_Point - `Noc_ID_X_Width - `Noc_ID_Y_Width)
`define Axi_Type_Point          (`Noc_Dest_Point - `Axi_TYPE_Bit)
`define Axi_Pack_Order_Point    (`Axi_Type_Point - `Axi_PACK_ORDER_Bit)
`define Axi_Len_Point           (`Axi_Pack_Order_Point - `Axi_LEN_Bit)
`define Noc_Point_E             (`Axi_Len_Point - `Noc_Head_Bit)

package Noc_parameters;
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
    localparam int                      Less_Byte               = Noc_Data_Width - Noc_Head_Bit * 2 - Noc_ID_X_Width * 2 - Noc_ID_Y_Width * 2 - Axi_TYPE_Bit - Axi_PACK_ORDER_Bit - Axi_LEN_Bit;
endpackage
`endif