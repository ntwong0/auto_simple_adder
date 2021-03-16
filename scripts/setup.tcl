# get the directory where this script resides
set thisDir [file dirname [info script]]
# source common utilities
source -notrace $thisDir/utils.tcl

set srcsRoot ../srcs
set xdcRoot ../xdc

# Create project
create_project -force simple_adder ./simple_adder/ -part xc7z020clg400-1

# Set project properties
set obj [get_projects simple_adder]
set_property "board_part" "digilentinc.com:zybo-z7-20:part0:1.0" $obj
set_property "simulator_language" "Verilog" $obj
set_property "target_language" "Verilog" $obj

add_files -norecurse $srcsRoot/simple_adder.v
add_files -norecurse $srcsRoot/tb_simple_adder.v
# add_files -norecurse -fileset constrs_1 $srcsRoot/Zybo-Z7.xdc

# If successful, "touch" a file so the make utility will know it's done 
touch {.setup.done}
