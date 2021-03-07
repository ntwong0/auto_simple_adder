# get the directory where this script resides
set thisDir [file dirname [info script]]
# source common utilities
source -notrace $thisDir/utils.tcl

# Open project
open_project ./simple_adder/simple_adder.xpr

# Implement and write_bitstream
launch_runs -jobs 8 impl_1
wait_on_run impl_1
open_run impl_1

write_bitstream bitstream.bit

# If successful, "touch" a file so the make utility will know it's done 
touch {.compile.done}