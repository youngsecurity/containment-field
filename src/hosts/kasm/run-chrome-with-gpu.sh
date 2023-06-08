#!/bin/sh

################################################################################
# Script Name: run-chrome-with-gpu.sh
# Description: Here is an example of a script that executes Google Chrome with
#              vglrun. The IF statement ensures the GPU has indeed been passed 
#              through, and if not launches Chrome normally. This is not 
#              necessary for most applications, Chrome happens to be one 
#              application that this is necessary for.
# Author: Joseph Young <joe@youngsecurity.net>
# Created: 2023/06/08
# Version: 1.0
################################################################################

# Exit immediately if a command exits with a non-zero status
set -e

# Define variables
#VAR1="value1"
#VAR2="value2"

# Define functions
#function my_function() {
#    echo "Hello, world!"
#}

# Main code
# Notify the user the script has started.
echo "Starting the script!"

# Call a function
#my_function

# Do some other things...
#echo "Variable 1 is: $VAR1"
#echo "Variable 2 is: $VAR2"

if [ -f /opt/VirtualGL/bin/vglrun ] && [ ! -z "\${KASM_EGL_CARD}" ] && [ ! -z "\${KASM_RENDERD}" ] && [ -O "\${KASM_RENDERD}" ] && [ -O "\${KASM_EGL_CARD}" ] ; then
    echo "Starting Chrome with GPU Acceleration on EGL device \${KASM_EGL_CARD}"
    vglrun -d "\${KASM_EGL_CARD}" /opt/google/chrome/google-chrome ${CHROME_ARGS} "\$@"
else
    echo "Starting Chrome"
    /opt/google/chrome/google-chrome ${CHROME_ARGS} "\$@"
fi

# Notify the user the script has completed.
echo "Script has finished!"