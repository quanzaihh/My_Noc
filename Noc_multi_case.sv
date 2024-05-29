/*
    created by: <Xidian University>
    created date: 2024-05-17
*/
interface Noc_multi_case #(
    parameter int N         = 5,
    parameter int DataWidth = 32
);

if (N == 1) begin : g
    function automatic logic [DataWidth-1:0] __noc_case_out(logic [N-1:0] noc_case, logic [N-1:0][DataWidth-1:0] noc_case_in);
        return noc_case_in[0];
    endfunction
end
else if (N == 2) begin : g
    function automatic logic [DataWidth-1:0] __noc_case_out(logic [N-1:0] noc_case, logic [N-1:0][DataWidth-1:0] noc_case_in);
        logic [1:0] noc_case_out;
        case (noc_case)
            2'b01: noc_case_out = noc_case_in[0];
            2'b10: noc_case_out = noc_case_in[1];
            default: return '0;
        endcase
        return noc_case_out;
    endfunction
end
else if (N == 3) begin : g
    function automatic logic [DataWidth-1:0] __noc_case_out(logic [N-1:0] noc_case, logic [N-1:0][DataWidth-1:0] noc_case_in);
        case (noc_case)
            3'b001: return noc_case_in[0];
            3'b010: return noc_case_in[1];
            3'b100: return noc_case_in[2];
            default: return '0;
        endcase
    endfunction
end
else if (N == 4) begin : g
    function automatic logic [DataWidth-1:0] __noc_case_out(logic [N-1:0] noc_case, logic [N-1:0][DataWidth-1:0] noc_case_in);
        case (noc_case)
            4'b0001: return noc_case_in[0];
            4'b0010: return noc_case_in[1];
            4'b0100: return noc_case_in[2];
            4'b1000: return noc_case_in[3];
            default: return '0;
        endcase
    endfunction
end
else if (N == 5) begin : g
    function automatic logic [DataWidth-1:0] __noc_case_out(logic [N-1:0] noc_case, logic [N-1:0][DataWidth-1:0] noc_case_in);
        case (noc_case)
            5'b00001: return noc_case_in[0];
            5'b00010: return noc_case_in[1];
            5'b00100: return noc_case_in[2];
            5'b01000: return noc_case_in[3];
            5'b10000: return noc_case_in[4];
            default: return '0;
        endcase
    endfunction
end
else if (N == 6) begin : g
    function automatic logic [DataWidth-1:0] __noc_case_out(logic [N-1:0] noc_case, logic [N-1:0][DataWidth-1:0] noc_case_in);
        case (noc_case)
            6'b000001: return noc_case_in[0];
            6'b000010: return noc_case_in[1];
            6'b000100: return noc_case_in[2];
            6'b001000: return noc_case_in[3];
            6'b010000: return noc_case_in[4];
            6'b100000: return noc_case_in[5];
            default: return '0;
        endcase
    endfunction
end
else if (N == 7) begin : g
    function automatic logic [DataWidth-1:0] __noc_case_out(logic [N-1:0] noc_case, logic [N-1:0][DataWidth-1:0] noc_case_in);
        case (noc_case)
            7'b0000001: return noc_case_in[0];
            7'b0000010: return noc_case_in[1];
            7'b0000100: return noc_case_in[2];
            7'b0001000: return noc_case_in[3];
            7'b0010000: return noc_case_in[4];
            7'b0100000: return noc_case_in[5];
            7'b1000000: return noc_case_in[6];
            default: return '0;
        endcase
    endfunction
end
else if (N == 8) begin : g
    function automatic logic [DataWidth-1:0] __noc_case_out(logic [N-1:0] noc_case, logic [N-1:0][DataWidth-1:0] noc_case_in);
        case (noc_case)
            8'b00000001: return noc_case_in[0];
            8'b00000010: return noc_case_in[1];
            8'b00000100: return noc_case_in[2];
            8'b00001000: return noc_case_in[3];
            8'b00010000: return noc_case_in[4];
            8'b00100000: return noc_case_in[5];
            8'b01000000: return noc_case_in[6];
            8'b10000000: return noc_case_in[7];
            default: return '0;
        endcase
    endfunction
end
else if (N == 9) begin : g
    function automatic logic [DataWidth-1:0] __noc_case_out(logic [N-1:0] noc_case, logic [N-1:0][DataWidth-1:0] noc_case_in);
        case (noc_case)
            9'b000000001: return noc_case_in[0];
            9'b000000010: return noc_case_in[1];
            9'b000000100: return noc_case_in[2];
            9'b000001000: return noc_case_in[3];
            9'b000010000: return noc_case_in[4];
            9'b000100000: return noc_case_in[5];
            9'b001000000: return noc_case_in[6];
            9'b010000000: return noc_case_in[7];
            9'b100000000: return noc_case_in[8];
            default: return '0;
        endcase
    endfunction
end
else if (N == 10) begin : g
    function automatic logic [DataWidth-1:0] __noc_case_out(logic [N-1:0] noc_case, logic [N-1:0][DataWidth-1:0] noc_case_in);
        case (noc_case)
            10'b0000000001: return noc_case_in[0];
            10'b0000000010: return noc_case_in[1];
            10'b0000000100: return noc_case_in[2];
            10'b0000001000: return noc_case_in[3];
            10'b0000010000: return noc_case_in[4];
            10'b0000100000: return noc_case_in[5];
            10'b0001000000: return noc_case_in[6];
            10'b0010000000: return noc_case_in[7];
            10'b0100000000: return noc_case_in[8];
            10'b1000000000: return noc_case_in[9];
            default: return '0;
        endcase
    endfunction
end
else if (N == 11) begin : g
    function automatic logic [DataWidth-1:0] __noc_case_out(logic [N-1:0] noc_case, logic [N-1:0][DataWidth-1:0] noc_case_in);
        case (noc_case)
            11'b00000000001: return noc_case_in[0];
            11'b00000000010: return noc_case_in[1];
            11'b00000000100: return noc_case_in[2];
            11'b00000001000: return noc_case_in[3];
            11'b00000010000: return noc_case_in[4];
            11'b00000100000: return noc_case_in[5];
            11'b00001000000: return noc_case_in[6];
            11'b00010000000: return noc_case_in[7];
            11'b00100000000: return noc_case_in[8];
            11'b01000000000: return noc_case_in[9];
            11'b10000000000: return noc_case_in[10];
            default: return '0;
        endcase
    endfunction
end
else if (N == 12) begin : g
    function automatic logic [DataWidth-1:0] __noc_case_out(logic [N-1:0] noc_case, logic [N-1:0][DataWidth-1:0] noc_case_in);
        case (noc_case)
            12'b000000000001: return noc_case_in[0];
            12'b000000000010: return noc_case_in[1];
            12'b000000000100: return noc_case_in[2];
            12'b000000001000: return noc_case_in[3];
            12'b000000010000: return noc_case_in[4];
            12'b000000100000: return noc_case_in[5];
            12'b000001000000: return noc_case_in[6];
            12'b000010000000: return noc_case_in[7];
            12'b000100000000: return noc_case_in[8];
            12'b001000000000: return noc_case_in[9];
            12'b010000000000: return noc_case_in[10];
            12'b100000000000: return noc_case_in[11];
            default: return '0;
        endcase
    endfunction
end
else if (N == 13) begin : g
    function automatic logic [DataWidth-1:0] __noc_case_out(logic [N-1:0] noc_case, logic [N-1:0][DataWidth-1:0] noc_case_in);
        case (noc_case)
            13'b0000000000001: return noc_case_in[0];
            13'b0000000000010: return noc_case_in[1];
            13'b0000000000100: return noc_case_in[2];
            13'b0000000001000: return noc_case_in[3];
            13'b0000000010000: return noc_case_in[4];
            13'b0000000100000: return noc_case_in[5];
            13'b0000001000000: return noc_case_in[6];
            13'b0000010000000: return noc_case_in[7];
            13'b0000100000000: return noc_case_in[8];
            13'b0001000000000: return noc_case_in[9];
            13'b0010000000000: return noc_case_in[10];
            13'b0100000000000: return noc_case_in[11];
            13'b1000000000000: return noc_case_in[12];
            default: return '0;
        endcase
    endfunction
end
else if (N == 14) begin : g
    function automatic logic [DataWidth-1:0] __noc_case_out(logic [N-1:0] noc_case, logic [N-1:0][DataWidth-1:0] noc_case_in);
        case (noc_case)
            14'b00000000000001: return noc_case_in[0];
            14'b00000000000010: return noc_case_in[1];
            14'b00000000000100: return noc_case_in[2];
            14'b00000000001000: return noc_case_in[3];
            14'b00000000010000: return noc_case_in[4];
            14'b00000000100000: return noc_case_in[5];
            14'b00000001000000: return noc_case_in[6];
            14'b00000010000000: return noc_case_in[7];
            14'b00000100000000: return noc_case_in[8];
            14'b00001000000000: return noc_case_in[9];
            14'b00010000000000: return noc_case_in[10];
            14'b00100000000000: return noc_case_in[11];
            14'b01000000000000: return noc_case_in[12];
            14'b10000000000000: return noc_case_in[13];
            default: return '0;
        endcase
    endfunction
end
else if (N == 15) begin : g
    function automatic logic [DataWidth-1:0] __noc_case_out(logic [N-1:0] noc_case, logic [N-1:0][DataWidth-1:0] noc_case_in);
        case (noc_case)
            15'b000000000000001: return noc_case_in[0];
            15'b000000000000010: return noc_case_in[1];
            15'b000000000000100: return noc_case_in[2];
            15'b000000000001000: return noc_case_in[3];
            15'b000000000010000: return noc_case_in[4];
            15'b000000000100000: return noc_case_in[5];
            15'b000000001000000: return noc_case_in[6];
            15'b000000010000000: return noc_case_in[7];
            15'b000000100000000: return noc_case_in[8];
            15'b000001000000000: return noc_case_in[9];
            15'b000010000000000: return noc_case_in[10];
            15'b000100000000000: return noc_case_in[11];
            15'b001000000000000: return noc_case_in[12];
            15'b010000000000000: return noc_case_in[13];
            15'b100000000000000: return noc_case_in[14];
            default: return '0;
        endcase
    endfunction
end
else if (N == 16) begin : g
    function automatic logic [DataWidth-1:0] __noc_case_out(logic [N-1:0] noc_case, logic [N-1:0][DataWidth-1:0] noc_case_in);
        case (noc_case)
            16'b0000000000000001: return noc_case_in[0];
            16'b0000000000000010: return noc_case_in[1];
            16'b0000000000000100: return noc_case_in[2];
            16'b0000000000001000: return noc_case_in[3];
            16'b0000000000010000: return noc_case_in[4];
            16'b0000000000100000: return noc_case_in[5];
            16'b0000000001000000: return noc_case_in[6];
            16'b0000000010000000: return noc_case_in[7];
            16'b0000000100000000: return noc_case_in[8];
            16'b0000001000000000: return noc_case_in[9];
            16'b0000010000000000: return noc_case_in[10];
            16'b0000100000000000: return noc_case_in[11];
            16'b0001000000000000: return noc_case_in[12];
            16'b0010000000000000: return noc_case_in[13];
            16'b0100000000000000: return noc_case_in[14];
            16'b1000000000000000: return noc_case_in[15];
            default: return '0;
        endcase
    endfunction
end

function automatic logic [DataWidth-1:0] set_case(logic [N-1:0] noc_case, logic [N-1:0][DataWidth-1:0] noc_case_in);
    return g.__noc_case_out(noc_case, noc_case_in);
endfunction

endinterface