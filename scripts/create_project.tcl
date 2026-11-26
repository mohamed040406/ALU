# From a Vivado Tcl shell: source scripts/create_project.tcl
set root [file dirname [file dirname [file normalize [info script]]]]
set project_dir [file join $root build alu]
set part xc7a35tcpg236-1
if {[info exists ::env(ALU_PART)]} {
    set part $::env(ALU_PART)
}
create_project alu $project_dir -part $part

foreach {folder pattern fileset} {
    rtl         *.v    sources_1
    tb          *.v    sim_1
} {
    set files [glob -nocomplain -directory [file join $root $folder] $pattern]
    if {[llength $files] > 0} {
        add_files -fileset $fileset -norecurse $files
    }
}

set_property include_dirs [list [file join $root tb]] [get_filesets sim_1]
