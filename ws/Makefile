# these are the sources - everything depends upon them
RTL=../srcs/simple_adder.v ../srcs/tb_simple_adder.v

# These are all the compilation targets, starting with "all"
all : setup create_axi create_bd compile bootgen

# This setups up the simple_adder project
setup : .setup.done
.setup.done : $(RTL)
	vivado -mode batch -source ../scripts/setup_simple.tcl -log setup.log -jou setup.jou

test : .test.done
.test.done : .setup.done
	vivado -mode batch -source ../scripts/test_simple.tcl -log test.log -jou test.jou

create_axi : .create_axi.done
.create_axi.done : .setup.done
	vivado -mode batch -source ../scripts/create_axi.tcl -log create_axi.log -jou create_axi.jou

create_bd : .create_bd.done
.create_bd.done : .create_axi.done
	vivado -mode batch -source ../scripts/create_bd.tcl -log create_bd.log -jou create_bd.jou

compile : .compile.done
.compile.done : .create_bd.done
	vivado -mode batch -source ../scripts/compile_simple.tcl -log compile.log -jou compile.jou

bootgen : .bootgen.done
.bootgen.done : .compile.done
	vivado -mode batch -source ../scripts/bootgen_simple.tcl -log bootgen.log -jou bootgen.jou

# delete everything except this Makefile
clean :	
	find . -not -name "Makefile*" -not -name "." | xargs rm -rf
delete_bd :
	vivado -mode batch -source ../scripts/delete_bd.tcl -log delete_bd.log -jou delete_bd.jou
	rm -rf bd/
	rm .create_bd.done
