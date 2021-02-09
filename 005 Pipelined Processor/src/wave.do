onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench/clk
add wave -noupdate /testbench/reset
add wave -noupdate -radix hexadecimal /testbench/Instr
add wave -noupdate -radix hexadecimal /testbench/dut/Instr
add wave -noupdate /testbench/dut/PC
add wave -noupdate /testbench/dut/DataAdr
add wave -noupdate /testbench/dut/ReadData
add wave -noupdate /testbench/dut/ShowData
add wave -noupdate /testbench/dut/ShowEn
add wave -noupdate /testbench/dut/cpu/dp/PCPlus4
add wave -noupdate /testbench/dut/cpu/dp/PCprime
add wave -noupdate /testbench/dut/cpu/dp/JMuxTakenE
add wave -noupdate /testbench/dut/cpu/dp/PCF
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {134 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 207
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
WaveRestoreZoom {0 ps} {291 ps}
