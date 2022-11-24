library verilog;
use verilog.vl_types.all;
entity ua_receiver is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        enable          : in     vl_logic;
        ser_in          : in     vl_logic;
        dout_byte       : out    vl_logic_vector(7 downto 0);
        dout_byte_rdy   : out    vl_logic;
        dout_byte_temp  : out    vl_logic_vector(9 downto 0)
    );
end ua_receiver;
