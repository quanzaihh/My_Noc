/*
    created by: <Xidian University>
    created date: 2024-05-16
*/

`timescale 1ns/1ps

module Noc_round_robin_arbiter import Noc_parameters::*; 
#(
    parameter int                 REQUESTS      = 2,
    parameter bit                 KEEP_RESULT   = 1,
    parameter bit [REQUESTS-1:0]  INITIAL_GRANT = 1
)
(
    input var logic                   noc_clk,
    input var logic                   noc_rst_n,
    input     logic [REQUESTS-1:0]    request,
    output    logic [REQUESTS-1:0]    o_grant,
    input     logic [REQUESTS-1:0]    free
);

logic                 busy;
logic                 grab_grant;
logic [REQUESTS-1:0]  grant;
logic [REQUESTS-1:0]  current_grant;
logic [REQUESTS-1:0]  grant_next;

if (KEEP_RESULT) begin
    always_ff @(posedge noc_clk or negedge noc_rst_n) begin
        if (!noc_rst_n) begin
            busy  <= '0;
        end else if ((grant & free) != '0) begin
            busy  <= '0;
        end else if (grab_grant) begin
            busy  <= '1;
        end
    end
end
else begin
    assign  busy  = '0;
end

//--------------------------------------------------------------
//  Generating Grant
//--------------------------------------------------------------
assign  o_grant     = grant;
assign  grant       = (grab_grant) ? grant_next
                    : (busy      ) ? current_grant : '0;
assign  grab_grant  = |(request & {REQUESTS{~busy}});

always_ff @(posedge noc_clk, negedge noc_rst_n) begin
    if (!noc_rst_n) begin
        current_grant <= INITIAL_GRANT;
    end
    else if (grab_grant) begin
        current_grant <= grant_next;
    end
end

assign  grant_next  = get_grant(current_grant, request);

Noc_one_hot #(.WIDTH(REQUESTS)) u_onehot();
Noc_multi_case #(.N(REQUESTS), .DataWidth(REQUESTS)) u_noc_case();

function automatic logic [REQUESTS-1:0] get_grant(
    logic [REQUESTS-1:0]  current_grant,
    logic [REQUESTS-1:0]  request
);
    logic [REQUESTS-1:0][REQUESTS-1:0]  grant_each;

    for (int i = 0;i < REQUESTS;++i) begin
        grant_each[i] = get_grant_each(request, i);
    end
    
    return u_noc_case.set_case(current_grant, grant_each);
endfunction

function automatic logic [REQUESTS-1:0] get_grant_each(
    logic [REQUESTS-1:0]  request,
    int                   index
);
    logic [2*REQUESTS-1:0]  request_temp;
    logic [1*REQUESTS-1:0]  request_rearranged;
    logic [1*REQUESTS-1:0]  grant;
    logic [2*REQUESTS-1:0]  grant_temp;
    request_temp        = {request, request};
    request_rearranged  = request_temp[index+1+:REQUESTS];
    grant               = u_onehot.to_onehot(request_rearranged);
    grant_temp          = {grant, grant};
    return grant_temp[REQUESTS-1-index+:REQUESTS];
endfunction

endmodule