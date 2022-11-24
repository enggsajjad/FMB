library verilog;
use verilog.vl_types.all;
entity clk_gen is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        en_tx           : out    vl_logic;
        en_rx           : out    vl_logic
    );
end clk_gen;
