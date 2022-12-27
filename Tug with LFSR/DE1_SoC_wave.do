onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /DE1_SoC_testbench/CLOCK_50
add wave -noupdate -radix hexadecimal /DE1_SoC_testbench/SW
add wave -noupdate {/DE1_SoC_testbench/KEY[0]}
add wave -noupdate -radix unsigned /DE1_SoC_testbench/dut/counterP2
add wave -noupdate /DE1_SoC_testbench/HEX0
add wave -noupdate /DE1_SoC_testbench/HEX5
add wave -noupdate -radix decimal /DE1_SoC_testbench/LEDR
add wave -noupdate /DE1_SoC_testbench/dut/R2
add wave -noupdate /DE1_SoC_testbench/dut/P2
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {445 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 115
configure wave -valuecolwidth 70
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {1792 ps}
