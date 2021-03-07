# get the directory where this script resides
set thisDir [file dirname [info script]]
# source common utilities
source -notrace $thisDir/utils.tcl

# Open project
open_project ./simple_adder/simple_adder.xpr

export_ip_user_files -of_objects  [get_files ./bd/design_1/design_1.bd] -no_script -reset -force -quiet
remove_files  ./bd/design_1/design_1.bd