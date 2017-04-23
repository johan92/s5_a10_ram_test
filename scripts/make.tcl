load_package flow

set project_name [lindex $argv 0]

project_open ${project_name} 

execute_flow -compile
project_close
