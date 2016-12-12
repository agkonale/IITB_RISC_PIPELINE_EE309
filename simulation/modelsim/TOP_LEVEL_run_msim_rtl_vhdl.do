transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/abhishek konale/Desktop/IITB_RISC_PIPELINE/SET_POS_ZERO.vhd}
vcom -93 -work work {C:/Users/abhishek konale/Desktop/IITB_RISC_PIPELINE/SE9.vhd}
vcom -93 -work work {C:/Users/abhishek konale/Desktop/IITB_RISC_PIPELINE/SE6.vhd}
vcom -93 -work work {C:/Users/abhishek konale/Desktop/IITB_RISC_PIPELINE/PRIORITY_ENCODER.vhd}
vcom -93 -work work {C:/Users/abhishek konale/Desktop/IITB_RISC_PIPELINE/MUX_16_8.vhd}
vcom -93 -work work {C:/Users/abhishek konale/Desktop/IITB_RISC_PIPELINE/LH9.vhd}
vcom -93 -work work {C:/Users/abhishek konale/Desktop/IITB_RISC_PIPELINE/General_Components.vhd}
vcom -93 -work work {C:/Users/abhishek konale/Desktop/IITB_RISC_PIPELINE/FULL_ADDER.vhd}
vcom -93 -work work {C:/Users/abhishek konale/Desktop/IITB_RISC_PIPELINE/DATA_REGISTER_16.vhd}
vcom -93 -work work {C:/Users/abhishek konale/Desktop/IITB_RISC_PIPELINE/DATA_REGISTER.vhd}
vcom -93 -work work {C:/Users/abhishek konale/Desktop/IITB_RISC_PIPELINE/ALU_Components.vhd}
vcom -93 -work work {C:/Users/abhishek konale/Desktop/IITB_RISC_PIPELINE/WRITE_BACK_STAGE.vhd}
vcom -93 -work work {C:/Users/abhishek konale/Desktop/IITB_RISC_PIPELINE/TOP_LEVEL.vhd}
vcom -93 -work work {C:/Users/abhishek konale/Desktop/IITB_RISC_PIPELINE/REGISTER_READ_STAGE.vhd}
vcom -93 -work work {C:/Users/abhishek konale/Desktop/IITB_RISC_PIPELINE/REGISTER_FILE.vhd}
vcom -93 -work work {C:/Users/abhishek konale/Desktop/IITB_RISC_PIPELINE/PROGRAM_MEMORY.vhd}
vcom -93 -work work {C:/Users/abhishek konale/Desktop/IITB_RISC_PIPELINE/MEMORY_ACCESS_STAGE.vhd}
vcom -93 -work work {C:/Users/abhishek konale/Desktop/IITB_RISC_PIPELINE/INSTRUCTION_FETCH_STAGE.vhd}
vcom -93 -work work {C:/Users/abhishek konale/Desktop/IITB_RISC_PIPELINE/INSTRUCTION_DECODE_STAGE.vhd}
vcom -93 -work work {C:/Users/abhishek konale/Desktop/IITB_RISC_PIPELINE/EXECUTION_STAGE.vhd}
vcom -93 -work work {C:/Users/abhishek konale/Desktop/IITB_RISC_PIPELINE/DATA_MEMORY.vhd}
vcom -93 -work work {C:/Users/abhishek konale/Desktop/IITB_RISC_PIPELINE/ALU.vhd}
vcom -93 -work work {C:/Users/abhishek konale/Desktop/IITB_RISC_PIPELINE/ADDER_16.vhd}

vcom -93 -work work {C:/Users/abhishek konale/Desktop/IITB_RISC_PIPELINE/Testbench_TOP_LEVEL.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cycloneive -L rtl_work -L work -voptargs="+acc"  Testbench_TOP_LEVEL

add wave *
view structure
view signals
run -all
