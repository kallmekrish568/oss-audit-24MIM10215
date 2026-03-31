#!/bin/bash
# Script 1: System Identity Report
# Author: Krishna Shukla | Reg No: 24MIM10215
# Course: Open Source Software | Capstone Project
# Purpose: Displays system information as a welcome screen, including
#          OS details, user info, uptime, and open-source license info.

# -----------------------------------------------------------------------
# VARIABLES - Store student and software information
# -----------------------------------------------------------------------
STUDENT_NAME="Krishna Shukla"
REG_NUMBER="24MIM10215"
SOFTWARE_CHOICE="Python"

# -----------------------------------------------------------------------
# SYSTEM INFO - Use command substitution $() to capture command output
# -----------------------------------------------------------------------
KERNEL=$(uname -r)                        # Linux kernel version
USER_NAME=$(whoami)                       # Current logged-in user
HOME_DIR=$HOME                            # User's home directory
UPTIME=$(uptime -p)                       # Human-readable uptime
CURRENT_DATE=$(date '+%d %B %Y %H:%M:%S') # Current date and time

# Detect distro name from /etc/os-release (standard on modern Linux)
# 'source' loads the file's key=value pairs as shell variables
if [ -f /etc/os-release ]; then
    source /etc/os-release
    DISTRO_NAME="$NAME $VERSION"
else
    # Fallback: use uname if /etc/os-release is not available
    DISTRO_NAME=$(uname -s)
fi

# Identify the OS license (Linux kernel is licensed under GPL v2)
OS_LICENSE="GNU General Public License version 2 (GPL v2)"

# -----------------------------------------------------------------------
# DISPLAY - Print formatted welcome screen using echo
# -----------------------------------------------------------------------
echo "========================================================"
echo "        Open Source Audit — System Identity Report"
echo "========================================================"
echo ""
echo "  Student  : $STUDENT_NAME ($REG_NUMBER)"
echo "  Software : $SOFTWARE_CHOICE"
echo ""
echo "-------- System Details ---------------------------------"
echo "  Distribution : $DISTRO_NAME"
echo "  Kernel       : $KERNEL"
echo "  Logged in as : $USER_NAME"
echo "  Home Dir     : $HOME_DIR"
echo "  Uptime       : $UPTIME"
echo "  Date/Time    : $CURRENT_DATE"
echo ""
echo "-------- Open Source License ----------------------------"
echo "  This operating system (Linux) is covered by:"
echo "  $OS_LICENSE"
echo ""
echo "  The GPL v2 grants users the freedom to:"
echo "    1. Run the program for any purpose"
echo "    2. Study and modify the source code"
echo "    3. Redistribute copies"
echo "    4. Distribute modified versions"
echo ""
echo "  Your chosen software ($SOFTWARE_CHOICE) is licensed under"
echo "  the Python Software Foundation License (PSF License),"
echo "  which is a permissive, OSI-approved open-source license."
echo "========================================================"
