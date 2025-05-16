onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib work zynq_blk_opt

do {wave.do}

view wave
view structure
view signals

do {zynq_blk.udo}

run -all

quit -force
