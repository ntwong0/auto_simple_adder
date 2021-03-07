# auto_simple_adder
A simple adder on Digilent's Zybo Z7-20, based on workflows presented in Xilinx's revision control tutorial (UG1198).

## Usage on Windows 10 via Command Prompt
```
rem from repo root
scripts env.bat
cd ws
make all
```

## Dependencies
1. Xilinx Vivado (confirmed with v2017.4)
2. Digilent's [Vivado Board Files](https://github.com/Digilent/vivado-boards)
3. Petalinux 2017.4 on the Zybo Z7-20
4. A driver file to interact with the programmable logic, such as [`zybo-ui`](https://bitbucket.org/zybo-2020/zybo-ui)