#!/bin/bash

# Git repository's URL
# This is intended to be an available, accessible, and public git repository's "HTTPS" URL.
gitURL='https://github.com/vrej-ab/quick-functions.git'

# Git timeout seconds to wait for git command.
gitTimeout=8

### Following parameter's values containing filenames, should be single-quoted.
# Temporary file to collect the existing functions list in it.
existingFunctionsList='existing-functions-list.tmp'
# Temporary file to collect the new functions list in it.
newFunctionsList='new-functions-list.tmp'
# Temporary file to collect the new functions in it.
newFunctionsTempFile='new-functions.tmp'

# Next script file to run.
# Value must be single-quoted with reletive path './'
nextScriptToRun='./_1_quick-source-functions-cleanup.sh'

# Git repository's root directory name.
gitRepoDir=$(basename -s .git $gitURL)

# Git timeout SIGNAL to be send to Git process if not finished in $gitTimeout seconds.
gitSignal=15 # Recommended signal is '15'
########################################################################################

if [ ! -f ${nextScriptToRun} ] ;then
  echo -e "\n[ERR]: \"${nextScriptToRun}\" file not available.\n"
  exit 1
fi

if [ -f "${newFunctionsTempFile}" ] && [ -f "${existingFunctionsList}" ] && [ -f "${newFunctionsList}"  ]  ;then
  echo -e "\n[WARN]: Either one or more of the following files already exists\n * \"${existingFunctionsList}\"\n * \"${newFunctionsList}\"\n * \"${newFunctionsTempFile}\"\n\tIf you don't want this file to be overwritten,\n\tplease answer the folloing question with 'n' indicating No and update corresponding parameter's value in this script!"

  read -p "Overwrite files? [n|y]: " your_answer

  if [ "${your_answer}" != 'y' ] ;then
    echo -e "\nUpdate the 'newFunctionsTempFile' | 'existingFunctionsList' | 'newFunctionsList' parameter's value in this script and try again.\n Exitting...\n"
    exit 1 
  fi
fi

timeout -s"${gitSignal}" "${gitTimeout}" git ls-remote "${gitURL}"
gitLsExitCode="${?}"

[ ${gitLsExitCode} -ne 0 ] && \
    echo -e "\n[WARN]: \"git ls-remote ${gitURL}\" Failed.'\n\tThe repository is not available/accessible." && \
    exit ${gitLsExitCode}

git clone "${gitURL}" && \
  echo -e "\n[INFO]: Git cloned successfully.\n" || \
  (echo -e "\n[ERR]: \"Git clone ${gitURL}\" Failed.\n" && exit 1)

> ${newFunctionsTempFile}
> ${existingFunctionsList}
> ${newFunctionsList}

find ./"${gitRepoDir}"/ -iname "*.sh" -type f -exec cat {} >> ${newFunctionsTempFile} \;

rm -rf ./"${gitRepoDir}"/

cat <<'EOF'
###########################################
#    Please run the following commands    #
# Simply copy each line and paste it in   #
# your terminal                           #
###########################################
EOF
echo -e "\ndeclare -F >> \"${existingFunctionsList}\"\nsource ${newFunctionsTempFile}\ndeclare -F >> \"${newFunctionsList}\"\n${nextScriptToRun}\n"

exit 0
