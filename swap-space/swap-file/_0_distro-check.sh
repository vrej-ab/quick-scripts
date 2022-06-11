#!/bin/bash
### Variables
compatible_distros=(ubuntu debian)
next_script_to_run='./_1_enable-swapfile.sh'

### Functions
set_destro_id(){
	for _distro in ${compatible_distros[*]} ;do
		distro_id=$(grep '^ID_LIKE=' /etc/os-release | awk -F'=' '{print $2}' | grep -Ei "${_distro}")
		if [ "${distro_id}" != '' ] ;then
			break
		fi
	done
}

check_dirtro_compatibility(){
	if [ "${distro_id}" == '' ] ;then
		echo -e "\n[ERROR]: Distro is not compatible! \n[INFO]: Compatible distros are: ${compatible_distros[*]}\n"
		exit 1
	fi
}

check_next_script_to_run(){
	if ! [ -f "${next_script_to_run}" ] ;then
		echo -e "\n[ERROR]: ${next_script_to_run} - file not found.\n"
		exit 2
	elif ! [ -x "${next_script_to_run}" ] ;then
		echo -e "\n[ERROR]: ${next_script_to_run} - file is not executable.\n"
		exit 2
	else
		read -rp "Confirm to run the: \"${next_script_to_run}\" script [y]: " confirmation
		if ! [ "${confirmation}" == 'y' ] ;then
			echo -e "\n[WARNING]: Not confirmed to run the next script, exitting...\n"
			exit 2
		else
			return 0
		fi
	fi
}

###############################

set_destro_id
check_dirtro_compatibility
check_next_script_to_run && \
	${next_script_to_run}

exit 0
