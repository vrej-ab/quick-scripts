#!/bin/bash

set -e -o pipefail

### Variables
_swapfile_dir_path='' # Empty path will assume '/' top level root directory!
_swapfile_file_name='SWAPFILE'
_swapfile="${_swapfile_dir_path}/${_swapfile_file_name}"
_swapfile_size='2'  # By Gigabyte

_used_commands_array=(fallocate chmod mkswap swapon)

### Functions
commands_check(){
  for cmnd in "${@}"; do
    command -v "${cmnd}" >/dev/null || \
      ( echo -e "\n[ERROR]: Command \"${cmnd}\" not available in the system.\n" ;
        exit 1
      )
  done
}

_check_file(){
  for _file in "${*}" ;do	
    if [ -f "${_file}" ]; then
      echo -e "\n[ERROR]: A file \"${_file}\" is available already. Terminating ...\n"
      exit 1
    fi
  done
}

_create_precised_file(){
  fallocate -l "${_swapfile_size}"G  "${_swapfile}"
}

_add_fstab_entry(){
  grep -q "${1}[[:space:]]*swap[[:space:]]*swap[[:space:]]*defaults[[:space:]]*0[[:space:]]*0" /etc/fstab		&& \
	  echo -e "\n[ERROR]: Similar entry found in /etc/fstab - please check and mannually configure if needed.\n"	&& \
	  grep -n "${1}[[:space:]]*swap[[:space:]]*swap[[:space:]]*defaults[[:space:]]*0[[:space:]]*0" /etc/fstab	&& \
	  echo "" && \
	  exit 2
  echo -e "\n### Swap-file entry\n${1} swap swap defaults 0 0" >> /etc/fstab
}

#########################################
commands_check	${_used_commands_array[@]}
_check_file	"${_swapfile}"
_create_precised_file

chmod 600 "${_swapfile}"	&& \
  mkswap "${_swapfile}"		&& \
  swapon "${_swapfile}"		&& \
  echo -e "\n[INFO]: Swap enabled on \"${_swapfile}\" successfully.\n[WARNNING]: Do you want to make it permanent by adding an entry in '/etc/fstab' file?" && \
  read -rp "         Confirm by 'y': " _confirm
  if [ "${_confirm}" == 'y' ] ;then
    _add_fstab_entry "${_swapfile}"
  fi
  
exit 0

