# add sum
add_wave {{/tb_simple_adder/dut/sum}} 

# log signals to .wdb (Vivado Waveform Database File)
log_wave -r /

# log the signals this time
restart
run -all