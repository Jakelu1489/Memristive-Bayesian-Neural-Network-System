onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+TDCchannel_0 -L xil_defaultlib -L secureip -O5 xil_defaultlib.TDCchannel_0

do {wave.do}

view wave
view structure

do {TDCchannel_0.udo}

run -all

endsim

quit -force
