onbreak {quit -f}
onerror {quit -f}

vsim -voptargs="+acc" -t 1ps -L xil_defaultlib -L secureip -lib xil_defaultlib xil_defaultlib.TDCchannel_0

do {wave.do}

view wave
view structure
view signals

do {TDCchannel_0.udo}

run -all

quit -force
