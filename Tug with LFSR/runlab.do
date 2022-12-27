# Create work library
vlib work

# Compile Verilog
#     All Verilog files that are part of this design should have
#     their own "vlog" line below.
vlog "./mux2_1.sv"
vlog "./mux4_1.sv"
vlog "./DE1_SoC.sv"
vlog "./seg7.sv"
vlog "./UPC.sv"
vlog "./simple.sv"
vlog "./clock_divider.sv"
vlog "./runwaylights.sv"
vlog "./userin.sv"
vlog "./playfield.sv"
vlog "./victory.sv"
vlog "./comparator.sv"
vlog "./LFSR.sv"
vlog "./counter.sv"

# Call vsim to invoke simulator
#     Make sure the last item on the line is the name of the
#     testbench module you want to execute.
vsim -voptargs="+acc" -t 1ps -lib work DE1_SoC_testbench

# Source the wave do file
#     This should be the file that sets up the signal window for
#     the module you are testing.
do DE1_SoC_wave.do

# Set the window types
view wave
view structure
view signals

# Run the simulation
run -all

# End
