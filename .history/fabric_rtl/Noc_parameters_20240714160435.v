/*
    created by: <Xidian University>
    created date: 2024-05-16
*/

`ifndef NOC_PARAMETERS_V
`define NOC_PARAMETERS_V

// Self Defined Parameters
`define Noc_Data_Width      128
`define Noc_Flit_Width      (`Noc_Data_Width + 2)
`define Noc_X_Size          2
`define Noc_Y_Size          2
`define Noc_VC_Channel      2
`define Noc_VC_Fifo_Depth   4

// Auto Calculation
`define Noc_Node_Num    (`Noc_X_Size * `Noc_Y_Size)
`define Noc_ID_X_Width  $clog2(`Noc_X_Size)
`define Noc_ID_Y_Width  $clog2(`Noc_Y_Size)

// Flit Definition (Head, Tail, Data)
`define Noc_Head_Bit            4
`define Axi_TYPE_Bit            3
`define Axi_PACK_ORDER_Bit      16
`define Axi_ADDR                32
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
`define Less_Byte               (`Noc_Data_Width - `Noc_Head_Bit * 2 - `Noc_ID_X_Width * 2 - `Noc_ID_Y_Width * 2 - `Axi_TYPE_Bit - `Axi_PACK_ORDER_Bit - `Axi_LEN_Bit)

`endif