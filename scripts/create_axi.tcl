# get the directory where this script resides
set thisDir [file dirname [info script]]
# source common utilities
source -notrace $thisDir/utils.tcl

# Open project
open_project ./simple_adder/simple_adder.xpr

# Create AXI IP peripheral
create_peripheral xilinx.com user axi_dut_iface 1.0 -dir ./ip_repo
add_peripheral_interface S00_AXI -interface_mode slave -axi_type lite [ipx::find_open_core xilinx.com:user:axi_dut_iface:1.0]
generate_peripheral -driver -bfm_example_design -debug_hw_example_design [ipx::find_open_core xilinx.com:user:axi_dut_iface:1.0]
write_peripheral [ipx::find_open_core xilinx.com:user:axi_dut_iface:1.0]
set_property  ip_repo_paths  ./ip_repo/axi_dut_iface_1.0 [current_project]
update_ip_catalog -rebuild

# Open IP and replace source files
ipx::edit_ip_in_project -upgrade true -name axi_dut_iface_v1_0_project -directory ./simple_adder/simple_adder.tmp/axi_dut_iface_v1_0_project ./ip_repo/axi_dut_iface_1.0/component.xml
update_files -from_files ../srcs/axi_dut_iface_v1_0_S00_AXI.v -to_files ./ip_repo/axi_dut_iface_1.0/hdl/axi_dut_iface_v1_0_S00_AXI.v -filesets [get_filesets *]
update_files -from_files ../srcs/axi_dut_iface_v1_0.v -to_files ./ip_repo/axi_dut_iface_1.0/hdl/axi_dut_iface_v1_0.v -filesets [get_filesets *]
set_property top axi_dut_iface_v1_0 [current_fileset]
update_compile_order -fileset sources_1

# Package changes to IP
set_property name axi_dut_iface [ipx::current_core]
set_property display_name axi_dut_iface [ipx::current_core]
set_property version 1.01 [ipx::current_core]
ipx::merge_project_changes files [ipx::current_core]
ipx::merge_project_changes hdl_parameters [ipx::current_core]

# Save changes to IP
set_property previous_version_for_upgrade xilinx.com:user:axi_dut_iface:1.0 [ipx::current_core]
set_property core_revision 1 [ipx::current_core]
ipx::create_xgui_files [ipx::current_core]
ipx::update_checksums [ipx::current_core]
ipx::save_core [ipx::current_core]

# If successful, "touch" a file so the make utility will know it's done 
touch {.create_axi.done}