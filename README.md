# auto_simple_adder
A sample revision controlled Vivado project for a simple adder on Digilent's Zybo Z7-20, based on workflows presented in Xilinx's revision control tutorial (UG1198).

## Quick Usage on Windows 10 via Command Prompt
```
rem Open command prompt to this README file's location.
rem Then, run the following:
scripts\env.bat
cd ws
make all
```

## Repo break-down
Vivado projects are typically not version-control friendly - project settings/config files typically use absolute path references to associate files and folders, which make it very difficult to export/share project resources with teammates/collaborators. Xilinx's UG1198 suggests an alternative to organizing and managing your project design/simulation/constraint/etc assets, and serves as the basis for this repo.

* `ws/` contains the `Makefile`, which automates the build process. Essentially, the `Makefile` calls various scripts in `scripts/` to execute various components of the design and implementation workflow. For the most part, these executions takes place in this directory.
* `scripts/` contains the aforementioned scripts:
    * `setup.tcl`: creates the Vivado project and adds design sources specified in `srcs/` to the project
    * `test.tcl`: adds the simulation source from `srcs/` to the Vivado project and executes behavioral simulation
    * `create_axi.tcl`: creates an AXI peripheral using Verilog sources for the peripheral from `srcs/`, and adds the peripheral to the Vivado project IP library
    * `create_bd.tcl`: creates a block diagram that ties together a Zynq Processing System, the AXI peripheral, and the top-level RTL design, then creates an HDL wrapper from the block diagram
    * `compile.tcl`: run synthesis, implementation, and bitstream generation on the Vivado project
    * `bootgen.tcl`: convert the generated bitstream file into a `.bit.bin` file compatible with Petalinux 2017.4 on the Zybo Z7-20.
* `srcs/` contains your project sources
    * For projects with numerous design and simulation sources, subdirectories are suggested. The `tcl` command for adding files is `add_files`, and the `-norecurse` flag should **not** be used when attempting to add files by directory.
    * The existing files are specific to the simple adder project:
        * `simple_adder.v`: the simple adder design source
        * `tb_simple_adder.v`: the simple adder's testbench/simulation source
        * `axi_dut_iface_v1_0.v`: the AXI peripheral wrapper design source
        * `axi_dut_iface_v1_0_S00_AXI.v`: the AXI peripheral design source
        * ~~`Zybo-Z7.xdc`: constraint source for the Zybo Z7-20~~ not needed for this project

## Adapting this repo to version control your project
1. Replace the design, simulation, and constraint files under `srcs/` with yours
    * In `axi_dut_iface_v1_0.v`, ports `write_to_slv_reg6` and `write_to_slv_reg7` are disabled. Consider re-enabling them in your design. 
2. Update the `.tcl` scripts in `scripts/`
    * The Vivado project name is `simple_adder`, so you'll want to replace all references to that in every `.tcl` file.
        * Only `bootgen.tcl` is exempt from this.
    * `setup.tcl`: replace the files listed in the `add_files` lines with your own
        * Consider removing the `–norecurse` flag to add sources by directory
    * `test.tcl`: replace the file listed in the `add_files` line with your own
3. Use `git` to commit and push your changes to your repo
    * Never used `git` before? Check out [this tutorial](https://www.youtube.com/watch?v=iv8rSLsi1xo)

## Dependencies
1. Xilinx Vivado (confirmed with v2017.4)
2. Digilent's [Vivado Board Files](https://github.com/Digilent/vivado-boards)
3. Petalinux 2017.4 on the Zybo Z7-20
4. A driver file to interact with the programmable logic, such as [`zybo-ui`](https://bitbucket.org/zybo-2020/zybo-ui)