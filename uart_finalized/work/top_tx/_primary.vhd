library verilog;
use verilog.vl_types.all;
entity top_tx is
    port(
        uart_ready      : out    vl_logic;
        ser_out         : out    vl_logic;
        rst             : in     vl_logic;
        clk             : in     vl_logic
    );
end top_tx;
