# get the directory where this script resides
set thisDir [file dirname [info script]]
# source common utilities
source -notrace $thisDir/utils.tcl

# create boot image format file
set outfile [open "bitstream.bif" w]
puts $outfile "all:\n{\n\t[pwd]/bitstream.bit\n}"
close $outfile

# run bootgen
exec bootgen -image bitstream.bif -arch zynq -process_bitstream bin

# If successful, "touch" a file so the make utility will know it's done 
touch {.bootgen.done}