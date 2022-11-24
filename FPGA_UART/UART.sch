VERSION 6
BEGIN SCHEMATIC
    BEGIN ATTR DeviceFamilyName "spartan2"
        DELETE all:0
        EDITNAME all:0
        EDITTRAIT all:0
    END ATTR
    BEGIN NETLIST
        SIGNAL XLXN_15
        BEGIN SIGNAL clk
            BEGIN ATTR LOC "p77"
                VERILOG all:0 wsynth:1
                VHDL all:0 wa:1 wd:1
            END ATTR
        END SIGNAL
        SIGNAL XLXN_17
        SIGNAL XLXN_18
        SIGNAL XLXN_24
        SIGNAL rx
        SIGNAL res
        SIGNAL XLXN_31(7:0)
        SIGNAL XLXN_42
        SIGNAL XLXN_45
        SIGNAL XLXN_47(7:0)
        SIGNAL XLXN_49
        SIGNAL tx
        PORT Input clk
        PORT Input rx
        PORT Input res
        PORT Output tx
        BEGIN BLOCKDEF ua_receiver
            TIMESTAMP 2008 8 1 5 47 40
            LINE N 64 32 0 32 
            LINE N 64 -224 0 -224 
            LINE N 64 -96 0 -96 
            LINE N 64 -32 0 -32 
            LINE N 320 -224 384 -224 
            LINE N 320 -32 384 -32 
            RECTANGLE N 320 -44 384 -20 
            RECTANGLE N 64 -256 320 68 
        END BLOCKDEF
        BEGIN BLOCKDEF clk_gen
            TIMESTAMP 2008 7 29 2 42 40
            RECTANGLE N 64 -128 320 0 
            LINE N 64 -96 0 -96 
            LINE N 64 -32 0 -32 
            LINE N 320 -96 384 -96 
            LINE N 320 -32 384 -32 
        END BLOCKDEF
        BEGIN BLOCKDEF test_uart
            TIMESTAMP 2008 7 21 8 37 58
            RECTANGLE N 64 -64 352 0 
            LINE N 64 -32 0 -32 
            RECTANGLE N 0 -44 64 -20 
            LINE N 352 -32 416 -32 
            RECTANGLE N 352 -44 416 -20 
        END BLOCKDEF
        BEGIN BLOCKDEF clkdll
            TIMESTAMP 2001 5 5 15 22 1
            LINE N 384 -512 320 -512 
            LINE N 384 -448 320 -448 
            LINE N 384 -384 320 -384 
            LINE N 0 -448 64 -448 
            LINE N 0 -512 64 -512 
            LINE N 0 -128 64 -128 
            LINE N 384 -128 320 -128 
            LINE N 384 -192 320 -192 
            LINE N 384 -256 320 -256 
            LINE N 384 -320 320 -320 
            LINE N 64 -432 80 -448 
            LINE N 80 -448 64 -464 
            LINE N 64 -496 80 -512 
            LINE N 80 -512 64 -528 
            RECTANGLE N 64 -576 320 -64 
        END BLOCKDEF
        BEGIN BLOCKDEF bufg
            TIMESTAMP 2001 2 2 12 51 12
            LINE N 64 -64 64 0 
            LINE N 128 -32 64 -64 
            LINE N 64 0 128 -32 
            LINE N 224 -32 128 -32 
            LINE N 0 -32 64 -32 
        END BLOCKDEF
        BEGIN BLOCKDEF ibufg
            TIMESTAMP 2001 2 2 12 53 1
            LINE N 64 0 64 -64 
            LINE N 128 -32 64 0 
            LINE N 64 -64 128 -32 
            LINE N 224 -32 128 -32 
            LINE N 0 -32 64 -32 
        END BLOCKDEF
        BEGIN BLOCKDEF ua_transmitter
            TIMESTAMP 2008 7 29 2 42 56
            LINE N 64 32 0 32 
            LINE N 64 -288 0 -288 
            LINE N 64 -160 0 -160 
            LINE N 64 -96 0 -96 
            LINE N 64 -32 0 -32 
            RECTANGLE N 0 -44 64 -20 
            LINE N 320 -288 384 -288 
            LINE N 320 -32 384 -32 
            RECTANGLE N 64 -320 320 64 
        END BLOCKDEF
        BEGIN BLOCK XLXI_4 test_uart
            PIN din_byte(7:0) XLXN_31(7:0)
            PIN dout_byte(7:0) XLXN_47(7:0)
        END BLOCK
        BEGIN BLOCK XLXI_5 clkdll
            BEGIN ATTR CLKDV_DIVIDE 8
                VERILOG all:0 dp:1nosynth wsynop:1 wsynth:1
                VHDL all:0 gm:1nosynth wa:1 wd:1
                VALUETYPE Float
            END ATTR
            PIN CLKFB XLXN_17
            PIN CLKIN XLXN_15
            PIN RST res
            PIN CLK0 XLXN_18
            PIN CLK180
            PIN CLK270
            PIN CLK2X
            PIN CLK90
            PIN CLKDV XLXN_45
            PIN LOCKED
        END BLOCK
        BEGIN BLOCK XLXI_6 bufg
            PIN I XLXN_18
            PIN O XLXN_17
        END BLOCK
        BEGIN BLOCK XLXI_7 ibufg
            PIN I clk
            PIN O XLXN_15
        END BLOCK
        BEGIN BLOCK XLXI_15 ua_receiver
            PIN clk XLXN_45
            PIN rst res
            PIN enable XLXN_42
            PIN ser_in rx
            PIN dout_byte_rdy XLXN_24
            PIN dout_byte(7:0) XLXN_31(7:0)
        END BLOCK
        BEGIN BLOCK XLXI_3 clk_gen
            PIN clk XLXN_45
            PIN rst res
            PIN en_rx XLXN_42
            PIN en_tx XLXN_49
        END BLOCK
        BEGIN BLOCK XLXI_16 ua_transmitter
            PIN clk XLXN_45
            PIN rst res
            PIN enable XLXN_49
            PIN din_rdy XLXN_24
            PIN din_byte(7:0) XLXN_47(7:0)
            PIN ser_out tx
            PIN uart_ready
        END BLOCK
    END NETLIST
    BEGIN SHEET 1 3520 2720
        BEGIN INSTANCE XLXI_5 976 864 R0
            BEGIN DISPLAY 0 -664 ATTR CLKDV_DIVIDE
                FONT 28 "Arial"
                DISPLAYFORMAT NAMEEQUALSVALUE
            END DISPLAY
        END INSTANCE
        INSTANCE XLXI_6 1440 384 R0
        INSTANCE XLXI_7 704 384 R0
        BEGIN BRANCH XLXN_15
            WIRE 928 352 976 352
        END BRANCH
        BEGIN BRANCH clk
            WIRE 672 352 704 352
        END BRANCH
        IOMARKER 672 352 clk R180 28
        BEGIN BRANCH XLXN_17
            WIRE 576 128 576 416
            WIRE 576 416 976 416
            WIRE 576 128 1744 128
            WIRE 1744 128 1744 352
            WIRE 1664 352 1744 352
        END BRANCH
        BEGIN BRANCH XLXN_18
            WIRE 1360 352 1440 352
        END BRANCH
        IOMARKER 688 896 res R180 28
        BEGIN BRANCH XLXN_31(7:0)
            WIRE 2368 448 2384 448
            WIRE 2384 448 2384 816
            WIRE 2384 816 2768 816
        END BRANCH
        BEGIN BRANCH rx
            WIRE 1680 448 1984 448
        END BRANCH
        IOMARKER 1680 448 rx R180 28
        BEGIN INSTANCE XLXI_15 1984 480 R0
        END INSTANCE
        BEGIN INSTANCE XLXI_3 1360 1136 R0
        END INSTANCE
        BEGIN INSTANCE XLXI_4 2768 848 R0
        END INSTANCE
        BEGIN BRANCH XLXN_42
            WIRE 1744 1040 1808 1040
            WIRE 1808 384 1984 384
            WIRE 1808 384 1808 1040
        END BRANCH
        BEGIN BRANCH res
            WIRE 688 896 832 896
            WIRE 832 896 832 1104
            WIRE 832 1104 1360 1104
            WIRE 832 896 1344 896
            WIRE 832 896 832 1776
            WIRE 832 1776 1792 1776
            WIRE 832 736 976 736
            WIRE 832 736 832 896
            WIRE 1344 864 1760 864
            WIRE 1344 864 1344 896
            WIRE 1760 512 1984 512
            WIRE 1760 512 1760 864
        END BRANCH
        BEGIN BRANCH XLXN_47(7:0)
            WIRE 1744 1712 1744 1872
            WIRE 1744 1872 3264 1872
            WIRE 1744 1712 1792 1712
            WIRE 3184 816 3264 816
            WIRE 3264 816 3264 1872
        END BRANCH
        BEGIN BRANCH XLXN_24
            WIRE 1632 1648 1632 1920
            WIRE 1632 1920 2272 1920
            WIRE 1632 1648 1792 1648
            WIRE 2272 608 2400 608
            WIRE 2272 608 2272 1920
            WIRE 2368 256 2400 256
            WIRE 2400 256 2400 608
        END BRANCH
        BEGIN BRANCH XLXN_49
            WIRE 1744 1104 1760 1104
            WIRE 1760 1104 1760 1584
            WIRE 1760 1584 1792 1584
        END BRANCH
        BEGIN BRANCH XLXN_45
            WIRE 1280 816 1424 816
            WIRE 1280 816 1280 1040
            WIRE 1280 1040 1360 1040
            WIRE 1280 1040 1280 1456
            WIRE 1280 1456 1792 1456
            WIRE 1360 672 1424 672
            WIRE 1424 672 1424 816
            WIRE 1424 256 1984 256
            WIRE 1424 256 1424 672
        END BRANCH
        BEGIN INSTANCE XLXI_16 1792 1744 R0
        END INSTANCE
        BEGIN BRANCH tx
            WIRE 2176 1456 2208 1456
        END BRANCH
        IOMARKER 2208 1456 tx R0 28
    END SHEET
END SCHEMATIC
