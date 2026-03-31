#!/bin/bash
# Script 5: Open Source Manifesto Generator
# Author: Krishna Shukla | Reg No: 24MIM10215
# Course: Open Source Software | Capstone Project
# Purpose: Interactively collects user input to generate a personalised
#          open-source philosophy statement and saves it to a .txt file.

# -----------------------------------------------------------------------
# ALIAS DEMONSTRATION
# Aliases are shortcuts for longer commands. In scripts they must be
# defined before use, and 'expand_aliases' must be set with shopt.
# These demonstrate the concept even though we use the full commands below.
# -----------------------------------------------------------------------
shopt -s expand_aliases              # Enable alias expansion in scripts
alias show_date='date "+%d %B %Y"'  # Alias: shortcut for formatted date
alias append='echo >>'              # Alias: conceptual shortcut for append

echo "========================================================"
echo "        Open Source Manifesto Generator"
echo "        Open Source Audit — Python"
echo "========================================================"
echo ""
echo "  Answer three questions to generate your personal"
echo "  open-source manifesto. Your answers will be woven"
echo "  into a philosophy statement that reflects your values."
echo ""
echo "========================================================"
echo ""

# -----------------------------------------------------------------------
# USER INPUT - 'read' captures input from the user
# -p flag displays a prompt before waiting for input
# -----------------------------------------------------------------------

# Question 1: An open-source tool the user uses every day
read -p "  1. Name one open-source tool you use every day: " TOOL

# Validate: if empty, provide a default
if [ -z "$TOOL" ]; then
    TOOL="Python"
    echo "     (No input provided, defaulting to: $TOOL)"
fi

echo ""

# Question 2: What 'freedom' means to the user in one word
read -p "  2. In one word, what does 'freedom' mean to you? " FREEDOM

# Validate: if empty, provide a default
if [ -z "$FREEDOM" ]; then
    FREEDOM="choice"
    echo "     (No input provided, defaulting to: $FREEDOM)"
fi

echo ""

# Question 3: Something the user would build and share freely
read -p "  3. Name one thing you would build and share freely: " BUILD

# Validate: if empty, provide a default
if [ -z "$BUILD" ]; then
    BUILD="a useful tool"
    echo "     (No input provided, defaulting to: $BUILD)"
fi

echo ""

# -----------------------------------------------------------------------
# DATE AND OUTPUT FILE - Generate filename and capture current date
# -----------------------------------------------------------------------
DATE=$(date '+%d %B %Y')              # Using the 'date' command directly
CURRENT_USER=$(whoami)                # Get the current username
OUTPUT="manifesto_${CURRENT_USER}.txt"  # Dynamic filename includes username

# -----------------------------------------------------------------------
# STRING CONCATENATION AND FILE WRITING
# Use echo with >> (append) to write multi-line output to the file
# Using > first to create/overwrite, then >> to append subsequent lines
# -----------------------------------------------------------------------

# Write the header to the file (> creates/overwrites the file)
echo "========================================" > "$OUTPUT"
echo "  OPEN SOURCE MANIFESTO" >> "$OUTPUT"
echo "  Generated on: $DATE" >> "$OUTPUT"
echo "  Author: $CURRENT_USER" >> "$OUTPUT"
echo "========================================" >> "$OUTPUT"
echo "" >> "$OUTPUT"

# Compose and write the personalised philosophy paragraph
# String variables are interpolated directly inside double-quoted echo strings
echo "I believe in the power of open source because every day I rely on" >> "$OUTPUT"
echo "$TOOL — a tool built not for profit, but for the freedom of everyone" >> "$OUTPUT"
echo "who uses it. To me, freedom means $FREEDOM. That is the spirit that" >> "$OUTPUT"
echo "drives open-source software: the idea that knowledge should belong to" >> "$OUTPUT"
echo "the people who need it, not only to those who can afford it." >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "Standing on the foundations that others have built and shared before me," >> "$OUTPUT"
echo "I commit to giving back. If I could build one thing and share it freely" >> "$OUTPUT"
echo "with the world, it would be $BUILD. Not because I am required to, but" >> "$OUTPUT"
echo "because the developers of $TOOL made that same choice for me — and it" >> "$OUTPUT"
echo "changed what was possible." >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "Open source is not just a licensing model. It is a belief that the world" >> "$OUTPUT"
echo "works better when we build in the open, share our work, and trust the" >> "$OUTPUT"
echo "community to improve on what we start." >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "========================================" >> "$OUTPUT"
echo "  Signed: $CURRENT_USER | $DATE" >> "$OUTPUT"
echo "========================================" >> "$OUTPUT"

# -----------------------------------------------------------------------
# CONFIRMATION AND DISPLAY
# -----------------------------------------------------------------------
echo "  ---- Manifesto Generated ----"
echo ""
echo "  Saved to: $OUTPUT"
echo ""
echo "  ---- Contents ----"
echo ""

# Display the saved file to the terminal
cat "$OUTPUT"

echo ""
echo "========================================================"
echo "  Your manifesto has been saved to: $OUTPUT"
echo "  Share it, keep it, or build on it — that's open source."
echo "========================================================"
