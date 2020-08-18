import os


initial = '''
set search_path [list . ~/tc/circuit_synthesis/lib/dff_full/]
set target_library ~/tc/circuit_synthesis/lib/dff_full/dff_full.db
set link_library ~/tc/circuit_synthesis/lib/dff_full/dff_full.db
set symbol_library [concat ~/tc/circuit_synthesis/lib/generic.sdb]
set hdlin_while_loop_iterations 1000000000

'''

files = [f[:-3] for f in os.listdir('.') if f.endswith('.sv') and f != 'multlayer1.sv']

files_compiler = ""

for f in files:
    files_compiler += '''

if {{ [file exists "./{}.ddc" ] == 1 }} {{

	puts "Skipping {} generation"

}} else {{
	analyze -format sverilog {}.sv
	set module {}
	set_design_top {}
	elaborate $module -architecture verilog -library DEFAULT -update

	set_max_area -ignore_tns 0
	set_flatten false -design *
	set_structure false -design *
	set_resource_allocation area_only
	report_compile_options

	compile -ungroup_all -map_effort low -area_effort none -no_design_rule

	write -output {}.ddc -hierarchy {}

	remove_design
}}

    \n'''.format(f,f,f,f,f,f,f)


reads = "\n".join(["read_ddc {}.ddc".format(f) for f in files])


end = '''

analyze -format sverilog multlayer1.sv
set module mlnn
elaborate $module -architecture verilog -library DEFAULT -update

set_design_top mlnn
current_design mlnn
check_design
list_designs

set_dont_touch [find cell operation_*]


set_max_area -ignore_tns 0 
set_flatten false -design *
set_structure false -design *
set_resource_allocation area_only
report_compile_options
#compile -ungroup_all -map_effort low -area_effort none -no_design_rule
ungroup -all -flatten -force -all_instances

write -output mlnn.ddc -hierarchy mlnn

write -hierarchy -format verilog -output syn/$module\_syn.v

exit
'''

outputfile = open("compile.dcsh", 'w')
outputfile.write(initial + files_compiler + reads + end)
outputfile.close()