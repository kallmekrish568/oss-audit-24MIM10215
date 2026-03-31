#!/bin/bash
# Script 3: Disk and Permission Auditor
# Author: Krishna Shukla | Reg No: 24MIM10215
# Course: Open Source Software | Capstone Project
# Purpose: Loops through key system directories and reports their
#          disk usage, permissions, and ownership information.

# -----------------------------------------------------------------------
# DIRECTORY LIST - Array of important Linux system directories to audit
# These directories are standard across most Linux distributions
# -----------------------------------------------------------------------
DIRS=("/etc" "/var/log" "/home" "/usr/bin" "/tmp" "/usr/lib" "/opt")

# Python's typical config/installation directories to check
PYTHON_DIRS=("/usr/lib/python3" "/usr/local/lib/python3" "/etc/python3")

echo "========================================================"
echo "        Disk and Permission Auditor"
echo "        Open Source Audit — Python"
echo "========================================================"
echo ""
echo "  Format: [permissions] [owner] [group] | Size"
echo ""
echo "  ---- Core System Directory Report ----"
echo ""

# -----------------------------------------------------------------------
# FOR LOOP - Iterate over each directory in the DIRS array
# The "${DIRS[@]}" syntax expands all array elements
# -----------------------------------------------------------------------
for DIR in "${DIRS[@]}"; do
    # Check if the directory exists before trying to inspect it
    # -d tests for directory existence
    if [ -d "$DIR" ]; then
        # ls -ld: list directory itself (not contents), long format
        # awk '{print $1, $3, $4}' extracts: permissions, owner, group
        PERMS=$(ls -ld "$DIR" | awk '{print $1, $3, $4}')

        # du -sh: disk usage, summary (-s), human-readable (-h)
        # 2>/dev/null: suppress permission denied errors
        # cut -f1: extract only the first tab-delimited field (size)
        SIZE=$(du -sh "$DIR" 2>/dev/null | cut -f1)

        # Handle case where size couldn't be determined (permission denied)
        if [ -z "$SIZE" ]; then
            SIZE="N/A (permission denied)"
        fi

        echo "  $DIR"
        echo "    Permissions/Owner/Group : $PERMS"
        echo "    Disk Usage              : $SIZE"
        echo ""
    else
        # Directory does not exist on this system
        echo "  $DIR => Does not exist on this system"
        echo ""
    fi
done

# -----------------------------------------------------------------------
# PYTHON-SPECIFIC SECTION - Check for Python's config directories
# This connects the audit to the chosen open-source software
# -----------------------------------------------------------------------
echo "  ---- Python (Chosen Software) Config Directory Check ----"
echo ""

# Flag to track if any Python directory was found
FOUND_PYTHON_DIR=false

for PYDIR in "${PYTHON_DIRS[@]}"; do
    # Use glob expansion to find versioned Python dirs (e.g., /usr/lib/python3.11)
    # The for loop handles the glob; if nothing matches, the literal string is returned
    for ACTUAL_DIR in ${PYDIR}*; do
        if [ -d "$ACTUAL_DIR" ]; then
            FOUND_PYTHON_DIR=true
            PERMS=$(ls -ld "$ACTUAL_DIR" | awk '{print $1, $3, $4}')
            SIZE=$(du -sh "$ACTUAL_DIR" 2>/dev/null | cut -f1)
            [ -z "$SIZE" ] && SIZE="N/A"

            echo "  [FOUND] $ACTUAL_DIR"
            echo "    Permissions/Owner/Group : $PERMS"
            echo "    Disk Usage              : $SIZE"
            echo ""
        fi
    done
done

# Inform user if no Python directories were found
if [ "$FOUND_PYTHON_DIR" = false ]; then
    echo "  No standard Python config directories found."
    echo "  Python may be installed in a non-standard location."
    echo ""
    # Try to find Python's actual location using the 'which' command
    if command -v python3 &>/dev/null; then
        PYTHON_BIN=$(which python3)
        echo "  Python binary found at: $PYTHON_BIN"
        ls -lh "$PYTHON_BIN"
        echo ""
    fi
fi

# -----------------------------------------------------------------------
# SECURITY NOTE - Explain why permissions matter for open-source software
# -----------------------------------------------------------------------
echo "  ---- Security Context Note ----"
echo ""
echo "  In Linux, file permissions control who can read, write, or execute"
echo "  files. Open-source software like Python installs its binaries in"
echo "  /usr/bin (owned by root) to prevent unauthorised modification."
echo "  Config files in /etc are also root-owned, ensuring system-wide"
echo "  settings cannot be altered by regular users."
echo ""
echo "========================================================"
