#!/bin/bash
# Script 4: Log File Analyzer
# Author: Krishna Shukla | Reg No: 24MIM10215
# Course: Open Source Software | Capstone Project
# Purpose: Reads a log file line by line, counts keyword occurrences,
#          and prints a summary with the last few matching lines.
# Usage:   ./script4_log_analyzer.sh /var/log/syslog [keyword]
#          ./script4_log_analyzer.sh /var/log/syslog error
#          ./script4_log_analyzer.sh /var/log/syslog warning

# -----------------------------------------------------------------------
# COMMAND-LINE ARGUMENTS
# $1 = first argument (log file path)
# $2 = second argument (keyword, defaults to "error" if not provided)
# -----------------------------------------------------------------------
LOGFILE=$1
KEYWORD=${2:-"error"}   # Default keyword is 'error' if none provided

# -----------------------------------------------------------------------
# INPUT VALIDATION - Check that a log file argument was provided
# -----------------------------------------------------------------------
if [ -z "$LOGFILE" ]; then
    echo "Usage: $0 <logfile> [keyword]"
    echo "Example: $0 /var/log/syslog error"
    exit 1
fi

echo "========================================================"
echo "        Log File Analyzer"
echo "        Open Source Audit — Python"
echo "========================================================"
echo ""
echo "  Log File : $LOGFILE"
echo "  Keyword  : '$KEYWORD'"
echo ""

# -----------------------------------------------------------------------
# FILE EXISTENCE CHECK WITH RETRY LOGIC
# If the file doesn't exist, suggest alternatives (do-while style retry)
# -----------------------------------------------------------------------

# Counter for retry attempts
ATTEMPT=0
MAX_ATTEMPTS=3

# Common Linux log files to try as fallbacks
FALLBACK_LOGS=("/var/log/syslog" "/var/log/messages" "/var/log/kern.log")

# Loop until a valid file is found or max attempts reached
until [ -f "$LOGFILE" ] || [ $ATTEMPT -ge $MAX_ATTEMPTS ]; do
    echo "  [WARNING] File not found: $LOGFILE"
    ATTEMPT=$((ATTEMPT + 1))

    # On each retry, try a fallback log file from the list
    if [ $ATTEMPT -le ${#FALLBACK_LOGS[@]} ]; then
        # Use index (ATTEMPT-1) to pick the next fallback
        FALLBACK="${FALLBACK_LOGS[$((ATTEMPT - 1))]}"
        echo "  [RETRY $ATTEMPT/$MAX_ATTEMPTS] Trying fallback: $FALLBACK"
        LOGFILE="$FALLBACK"
    fi
done

# After the retry loop, check if we finally have a valid file
if [ ! -f "$LOGFILE" ]; then
    echo "  [ERROR] No accessible log file found after $MAX_ATTEMPTS attempts."
    echo ""
    echo "  Common log file locations on Linux:"
    echo "    /var/log/syslog        (Debian/Ubuntu)"
    echo "    /var/log/messages      (RHEL/CentOS/Fedora)"
    echo "    /var/log/kern.log      (kernel messages)"
    echo "    /var/log/auth.log      (authentication events)"
    echo ""
    echo "  Note: Some logs require sudo to read."
    exit 1
fi

echo "  [OK] Reading file: $LOGFILE"
echo ""

# -----------------------------------------------------------------------
# CHECK FOR EMPTY FILE before processing
# -----------------------------------------------------------------------
if [ ! -s "$LOGFILE" ]; then
    echo "  [WARNING] The file exists but is empty. Nothing to analyze."
    exit 0
fi

# -----------------------------------------------------------------------
# LINE-BY-LINE ANALYSIS using while read loop
# IFS= prevents leading/trailing whitespace from being stripped
# -r prevents backslash interpretation
# -----------------------------------------------------------------------
COUNT=0          # Counter for matching lines
TOTAL_LINES=0    # Counter for total lines processed

while IFS= read -r LINE; do
    # Increment total line counter for each line read
    TOTAL_LINES=$((TOTAL_LINES + 1))

    # if-then: check if the current line contains the keyword
    # grep -iq: case-insensitive (-i), quiet mode (-q, no output, just exit code)
    if echo "$LINE" | grep -iq "$KEYWORD"; then
        COUNT=$((COUNT + 1))   # Increment match counter
    fi

done < "$LOGFILE"   # Redirect file into the while loop as input

# -----------------------------------------------------------------------
# SUMMARY OUTPUT
# -----------------------------------------------------------------------
echo "  ---- Analysis Summary ----"
echo ""
echo "  Total lines scanned : $TOTAL_LINES"
echo "  Keyword matches     : $COUNT occurrences of '$KEYWORD'"

# Calculate percentage of matching lines (using awk for floating-point)
if [ $TOTAL_LINES -gt 0 ]; then
    PERCENT=$(awk "BEGIN {printf \"%.2f\", ($COUNT / $TOTAL_LINES) * 100}")
    echo "  Match percentage    : $PERCENT%"
fi

echo ""

# -----------------------------------------------------------------------
# LAST 5 MATCHING LINES - Show context around the keyword
# Combine grep and tail to extract the last 5 matching lines
# -----------------------------------------------------------------------
if [ $COUNT -gt 0 ]; then
    echo "  ---- Last 5 Lines Matching '$KEYWORD' ----"
    echo ""
    # grep -i: case-insensitive search
    # tail -5: show only the last 5 results
    # sed 's/^/    /': indent each line with 4 spaces for readability
    grep -i "$KEYWORD" "$LOGFILE" | tail -5 | sed 's/^/    /'
    echo ""
else
    echo "  No lines containing '$KEYWORD' were found in this log file."
    echo ""
fi

echo "========================================================"
