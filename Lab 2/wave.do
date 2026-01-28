onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench/a
add wave -noupdate /testbench/b
add wave -noupdate /testbench/sum
add wave -noupdate /testbench/diff
add wave -noupdate /testbench/of_s
add wave -noupdate /testbench/of_d
add wave -noupdate /testbench/lessthan
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
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
WaveRestoreZoom {0 ps} {84 ps}
