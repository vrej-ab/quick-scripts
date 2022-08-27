#!/bin/bash

if [ -f './_0_quick-source-functions.sh' ] ;then
  grep -q 'existingFunctionsList=' ./_0_quick-source-functions.sh && \
    existingFunctionsList=$(grep 'existingFunctionsList=' ./_0_quick-source-functions.sh | cut -d"'" -f2)
  grep -q 'newFunctionsList=' ./_0_quick-source-functions.sh      && \
    newFunctionsList=$(grep 'newFunctionsList=' ./_0_quick-source-functions.sh | cut -d"'" -f2)
  grep -q 'newFunctionsTempFile=' ./_0_quick-source-functions.sh  && \
    newFunctionsTempFile=$(grep 'newFunctionsTempFile=' ./_0_quick-source-functions.sh | cut -d"'" -f2)
fi
#echo ${existingFunctionsList}
#echo ${newFunctionsList}
#echo ${newFunctionsTempFile}

cat <<'EOF'

# The following functions are added to your current shell
# If you want to make them permanent add them toy your .bashrc file to have them
# on every new session.

EOF
diff "${existingFunctionsList}" "${newFunctionsList}" | grep  '^>' | awk '{print $NF}'

if [ -f "${existingFunctionsList}" ] || [ -f "${newFunctionsList}" ] || [ -f "${newFunctionsTempFile}" ] ;then
  rm -f "${existingFunctionsList}" "${newFunctionsList}" "${newFunctionsTempFile}"
fi

exit 0
