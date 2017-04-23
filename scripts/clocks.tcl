load_package flow

set project_name [lindex $argv 0]

project_open ${project_name} 

create_timing_netlist -model slow

read_sdc

update_timing_netlist

set analysis_type "setup"

set clock_domain_info_list [get_clock_domain_info -${analysis_type}]

post_message $clock_domain_info_list

foreach domain_info $clock_domain_info_list {

    # The domain_info has the clock name, its slack, and its TNS.
    # Extract those.
    foreach { clock_name slack endpoint_tns edge_tns } $domain_info \
        { break }

    report_timing -from_clock "$clock_name" -to_clock "$clock_name" -${analysis_type} -npaths 1000 -detail full_path -panel_name {$clock_name $analysis_display_name} -file "output_files/$project_name.$clock_name.paths.rpt"
}
