# Software Project

## VHDL brief introduction
VHDL, or better VHSIC-HDL (Very High Speed Integrated Circuit Hardware Description Language), is a hardware description language, used in electronic design automatation to describe digital and mixed signal systems such as FPGAs (Field Programmable Gate Arrays) and ASICs (Application Specific Integrated Circuits). 

A VHDL project development is divided into 4 phases:

- Register Transfer Level (RTL): i.e. the source codes which, through the libraries provided by the language, includes the "built"  electronic circuit of interest (so called Architecture);
- Simulation: test of the built circuit by setting the input signals and studying the output ones (this part is still done in software);
- Synthesis: creation of the logic scheme and instantiation of the for a generic FPGA (not specific one) and creation of a list of needed components to be implemented (Netlist);
- Implementation: physical implementation of the type and number of components on a real FPGA (of course different FPGAs have different features). 

The last two parts of the project development may be done only if a physical hardware is present, thus for the pourpose of the project only the first two steps will be developed.

## GHDL installation and compiler 
Before getting started, to run the codes in this repository (written in VHDL) you need to install a free compiler for such codes. It should not take longer than 15 minutes (if you have a low connection like me).
To execute the codes, I suggest to use GHDL, which is easy to hadle, and suits perfectly for the pourposes of this project. Beware, this software in not able to provide a Synthesis phase (thus no netlist will be produced).
In any case, here is a simple tutorial to install and compile in GHDL.
From your power shell type the following lines to install and to clone the [GHDL](https://github.com/ghdl/ghdl) repository:
```
sudo apt update
sudo apt install -y git make gnat zlib1g-dev
git clone https://github.com/ghdl/ghdl
cd ghdl
./configure --prefix=/usr/local
make
sudo make install
```
This commands should work on Unix systems (I personally use Ubuntu 18.04.4 and it works), but for additional notes ad hints on installation please check the [GHDL-install](http://ghdl.free.fr/site/pmwiki.php?n=Main.Installation) site.
Moreover, GHDL does not provide any graphical displayer, so to display the signal of the source code and of the test bench you can install another free software for graphical visualization of the electronic signals [GKTwave](http://gtkwave.sourceforge.net/):
```
sudo apt-get install gtkwave
```
So far, if everything has been done correctly, you should now be able to used all the needed tools.

In GHDL many commands are available, for instance:

- ```ghdl -s``` makes a syntax check of the files;
- ```ghdl -a``` analyze the files;
- ```ghdl -e``` elaborate the defined units in the files (Architecture);
- ```ghdl -r``` runs the files.

For deeper details for the various compiling options you can type from the shell the option:
```
ghdl --help
```
The following lines are a simple example on how to check, analyze, execute and run the files and eventually display them in the GTKwave software: 
```
cd ~/path/to/the/repository/
ghdl -s library.vhd
ghdl -s source_file_name.vhd
ghdl -s test_bench.vhd
ghdl -a library.vhd
ghdl -a source_file_name.vhd
ghdl -a test_bench.vhd
ghdl -e test_bench
ghdl -r test_bench --vcd=source_file_name.vcd
gtkwave source_file_name.vcd
```
## 
