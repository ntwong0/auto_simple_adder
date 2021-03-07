# get the directory where this script resides
set thisDir [file dirname [info script]]
# source common utilities
source -notrace $thisDir/utils.tcl

# Open project
open_project ./simple_adder/simple_adder.xpr

# Create AXI IP peripheral
# update_compile_order -fileset sources_1
# create_bd_design "design_1"
create_bd_design -dir ./bd "design_1"
startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 processing_system7_0
endgroup
startgroup
create_bd_cell -type ip -vlnv xilinx.com:user:axi_dut_iface:1.01 axi_dut_iface_0
endgroup
create_bd_cell -type module -reference simple_adder simple_adder_0
# connect_bd_net [get_bd_pins axi_dut_iface_0/read_from_slv_reg0] [get_bd_pins dut_wrapper_0/read_from_slv_reg0] ;# config
# connect_bd_net [get_bd_pins axi_dut_iface_0/read_from_slv_reg1] [get_bd_pins dut_wrapper_0/read_from_slv_reg1] ;# control
# connect_bd_net [get_bd_pins axi_dut_iface_0/read_from_slv_reg2] [get_bd_pins simple_adder_0/read_from_slv_reg2] ;# switches
connect_bd_net [get_bd_pins axi_dut_iface_0/read_from_slv_reg2] [get_bd_pins simple_adder_0/input_a] ;# switches
# connect_bd_net [get_bd_pins axi_dut_iface_0/read_from_slv_reg3] [get_bd_pins simple_adder_0/read_from_slv_reg3] ;# buttons
connect_bd_net [get_bd_pins axi_dut_iface_0/read_from_slv_reg3] [get_bd_pins simple_adder_0/input_b] ;# buttons
# connect_bd_net [get_bd_pins axi_dut_iface_0/read_from_slv_reg4] [get_bd_pins dut_wrapper_0/read_from_slv_reg4] ;# button behavior
# connect_bd_net [get_bd_pins axi_dut_iface_0/write_to_slv_reg5]  [get_bd_pins simple_adder_0/write_to_slv_reg5]  ;# leds
connect_bd_net [get_bd_pins axi_dut_iface_0/write_to_slv_reg5]  [get_bd_pins simple_adder_0/output_y]  ;# leds
# connect_bd_net [get_bd_pins axi_dut_iface_0/write_to_slv_reg6]  [get_bd_pins dut_wrapper_0/write_to_slv_reg6]  ;# 7seg
# connect_bd_net [get_bd_pins axi_dut_iface_0/write_to_slv_reg7]  [get_bd_pins dut_wrapper_0/write_to_slv_reg7]  ;# status
startgroup
# make_bd_pins_external  [get_bd_pins dut_wrapper_0/sysclk]
endgroup
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config {Master "/processing_system7_0/M_AXI_GP0" intc_ip "New AXI Interconnect" Clk_xbar "Auto" Clk_master "Auto" Clk_slave "Auto" }  [get_bd_intf_pins axi_dut_iface_0/S00_AXI]
apply_bd_automation -rule xilinx.com:bd_rule:processing_system7 -config {make_external "FIXED_IO, DDR" apply_board_preset "1" Master "Disable" Slave "Disable" }  [get_bd_cells processing_system7_0]
regenerate_bd_layout
# make_wrapper -files [get_files C:/Users/fishie2610/Documents/xilinx_ws/examples_140/project_7/project_7.srcs/sources_1/bd/design_1/design_1.bd] -top
make_wrapper -files [get_files ./bd/design_1/design_1.bd] -top
# add_files -norecurse C:/Users/fishie2610/Documents/xilinx_ws/examples_140/project_7/project_7.srcs/sources_1/bd/design_1/hdl/design_1_wrapper.v
add_files -norecurse ./bd/design_1/hdl/design_1_wrapper.v
update_compile_order -fileset sources_1
set_property top design_1_wrapper [current_fileset]
update_compile_order -fileset sources_1


# If successful, "touch" a file so the make utility will know it's done 
touch {.create_bd.done}