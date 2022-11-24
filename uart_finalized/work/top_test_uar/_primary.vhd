library verilog;
use verilog.vl_types.all;
entity top_test_uar is
    port(
        uart_ready      : out    vl_logic;
        ff2_out         : out    vl_logic;
        ser_out         : out    vl_logic;
        ff1_out         : out    vl_logic;
        dout_byte_rdy   : out    vl_logic;
        enable2         : in     vl_logic;
        enable1         : in     vl_logic;
        din_rdy         : in     vl_logic;
        rst_n           : in     vl_logic;
        clk             : in     vl_logic;
        shift_count     : out    vl_logic_vector(3 downto 0);
        dout_byte_temp  : out    vl_logic_vector(9 downto 0);
        data_buf        : out    vl_logic_vector(8 downto 0);
        dout_byte       : out    vl_logic_vector(7 downto 0);
        din_byte        : in     vl_logic_vector(7 downto 0)
    );
end top_test_uar;
