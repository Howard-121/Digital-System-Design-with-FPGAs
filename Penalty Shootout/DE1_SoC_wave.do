onerror {resume}
radix define 7segHex {
    "7'b1000000" "0" -color "white",
    "7'b1111001" "1" -color "white",
    "7'b0100100" "2" -color "white",
    "7'b0110000" "3" -color "white",
    "7'b0011001" "4" -color "white",
    "7'b0010010" "5" -color "white",
    -default binary
}
quietly WaveActivateNextPane {} 0
add wave -noupdate /DE1_SoC_testbench/CLOCK_50
add wave -noupdate -radix hexadecimal {/DE1_SoC_testbench/SW[9]}
add wave -noupdate -expand /DE1_SoC_testbench/KEY
add wave -noupdate /DE1_SoC_testbench/HEX0
add wave -noupdate /DE1_SoC_testbench/HEX5
add wave -noupdate /DE1_SoC_testbench/goalkeeper_x
add wave -noupdate /DE1_SoC_testbench/player_y
add wave -noupdate /DE1_SoC_testbench/player_x
add wave -noupdate /DE1_SoC_testbench/check
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
WaveRestoreZoom {0 ps} {1712 ps}
