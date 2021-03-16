# get the directory where this script resides
set thisDir [file dirname [info script]]
# source common utilities
source -notrace $thisDir/utils.tcl

# set srcsRoot ../srcs

# Open project
open_project ./simple_adder/simple_adder.xpr

# Set files
set_property top tb_simple_adder [get_filesets sim_1]


# Run this script at end of the simulation
add_files -fileset sim_1 -norecurse $thisDir/post.tcl

# step 1. Check files for errors; taken care of by launch_simulation
# xvlog $srcsRoot/simple_adder.v $srcsRoot/tb_simple_adder.v
# step 2. Create simulation snapshot; taken care of by launch_simulation
# xelab $srcsRoot/tb_simple_adder.v -debug typical --snapshot tb_simple_adder_behav
# step 3. run the sim; do this with .wdb later, if visualization is desired
# xsim

# Run simulation
launch_simulation -simset sim_1 -mode behavioral

# generate .wcfg (Vivado Waveform Config File, for visualizing .wdb)
save_wave_config tb_simple_adder_behav

close_sim

touch {.test.done}
