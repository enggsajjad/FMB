VERSION 6
BEGIN SCHEMATIC
    BEGIN ATTR DeviceFamilyName "spartan2"
        DELETE all:0
        EDITNAME all:0
        EDITTRAIT all:0
    END ATTR
    BEGIN NETLIST
        BEGIN SIGNAL Port1
            BEGIN ATTR LOC "p162"
                VERILOG all:0 wsynth:1
                VHDL all:0 wa:1 wd:1
            END ATTR
        END SIGNAL
        BEGIN SIGNAL LcdEN
            BEGIN ATTR LOC "p151"
                VERILOG all:0 wsynth:1
                VHDL all:0 wa:1 wd:1
            END ATTR
        END SIGNAL
        PORT Input Port1
        PORT Output LcdEN
        BEGIN BLOCKDEF obuf
            TIMESTAMP 2001 2 2 12 53 1
            LINE N 64 0 64 -64 
            LINE N 128 -32 64 0 
            LINE N 64 -64 128 -32 
            LINE N 0 -32 64 -32 
            LINE N 224 -32 128 -32 
        END BLOCKDEF
        BEGIN BLOCK XLXI_2 obuf
            PIN I Port1
            PIN O LcdEN
        END BLOCK
    END NETLIST
    BEGIN SHEET 1 3520 2720
        INSTANCE XLXI_2 1552 976 R0
        BEGIN BRANCH Port1
            WIRE 1520 944 1552 944
        END BRANCH
        IOMARKER 1520 944 Port1 R180 28
        BEGIN BRANCH LcdEN
            WIRE 1776 944 1808 944
        END BRANCH
        IOMARKER 1808 944 LcdEN R0 28
    END SHEET
END SCHEMATIC
