# OSS Audit — Python
### Open Source Software Capstone Project

| Field | Details |
|-------|---------|
| **Student Name** | Krishna Shukla |
| **Registration Number** | [Your Reg Number] |
| **Chosen Software** | Python (PSF License) |
| **Course** | Open Source Software — NGMC |

---

## About This Project

This repository is part of **The Open Source Audit**, a capstone project for the Open Source Software course. It contains five shell scripts that demonstrate practical Linux skills, each tied to the analysis of **Python** as an open-source software project.

---

## Chosen Software: Python

Python is a free, open-source, high-level programming language governed by the **Python Software Foundation (PSF)**. It is licensed under the **PSF License**, a permissive, OSI-approved open-source license that grants all four freedoms of free software. Python is one of the most widely used programming languages in the world and is built entirely through community contribution.

---

## Repository Structure

```
oss-audit-24MIM10215/
├── README.md                        ← This file
├── script1_system_identity.sh       ← System Identity Report
├── script2_package_inspector.sh     ← FOSS Package Inspector
├── script3_disk_auditor.sh          ← Disk and Permission Auditor
├── script4_log_analyzer.sh          ← Log File Analyzer
└── script5_manifesto_generator.sh   ← Open Source Manifesto Generator
```

---

## Scripts — Description and Usage

### Script 1: System Identity Report
**File:** `script1_system_identity.sh`

Displays a formatted welcome screen showing the Linux distribution name, kernel version, currently logged-in user, home directory, system uptime, current date/time, and the open-source license covering the OS and chosen software.

**Shell concepts used:** Variables, `echo`, command substitution `$()`, `source`, conditional file checking.

**Run:**
```bash
chmod +x script1_system_identity.sh
./script1_system_identity.sh
```

---

### Script 2: FOSS Package Inspector
**File:** `script2_package_inspector.sh`

Checks whether Python is installed on the system using either `rpm` or `dpkg` (auto-detected), retrieves version and license information, and uses a `case` statement to print a philosophy note about the package.

**Shell concepts used:** `if-then-else`, `case` statement, `rpm -qi`, `dpkg -l`, pipe with `grep`, `command -v` for tool detection.

**Run:**
```bash
chmod +x script2_package_inspector.sh
./script2_package_inspector.sh
```

---

### Script 3: Disk and Permission Auditor
**File:** `script3_disk_auditor.sh`

Loops through a predefined list of important system directories and reports the permissions, owner, group, and disk usage of each. Includes an additional section specifically checking Python's installation directories.

**Shell concepts used:** `for` loop, arrays, `ls -ld`, `du -sh`, `awk`, `cut`, directory existence check with `[ -d ]`.

**Run:**
```bash
chmod +x script3_disk_auditor.sh
./script3_disk_auditor.sh
```

---

### Script 4: Log File Analyzer
**File:** `script4_log_analyzer.sh`

Reads a log file line by line, counts how many lines contain a given keyword (default: `error`), prints a summary with match percentage, and displays the last 5 matching lines. Includes retry logic if the specified file is not found.

**Shell concepts used:** `while read` loop, `if-then`, counter variables, command-line arguments (`$1`, `$2`), `until` loop for retry, `grep`, `tail`, `sed`.

**Run:**
```bash
chmod +x script4_log_analyzer.sh
./script4_log_analyzer.sh /var/log/syslog error
./script4_log_analyzer.sh /var/log/messages warning
```

**Dependencies:** Access to a readable log file (e.g., `/var/log/syslog` on Ubuntu, `/var/log/messages` on RHEL/CentOS). May require `sudo` for some log files.

---

### Script 5: Open Source Manifesto Generator
**File:** `script5_manifesto_generator.sh`

Interactively asks the user three questions and generates a personalised open-source philosophy statement. Saves the output to a `.txt` file named `manifesto_[username].txt` and displays it on screen.

**Shell concepts used:** `read` for interactive input, string concatenation, file writing with `>` and `>>`, `date` command, `alias` and `shopt` demonstration, input validation.

**Run:**
```bash
chmod +x script5_manifesto_generator.sh
./script5_manifesto_generator.sh
```

---

## Running All Scripts (Quick Start)

```bash
# Clone the repository
git clone https://github.com/krishna-shukla/oss-audit-24MIM10215.git
cd oss-audit-24MIM10215

# Make all scripts executable
chmod +x *.sh

# Run each script
./script1_system_identity.sh
./script2_package_inspector.sh
./script3_disk_auditor.sh
./script4_log_analyzer.sh /var/log/syslog error
./script5_manifesto_generator.sh
```

---

## System Requirements

- **OS:** Any Linux distribution (Ubuntu, Debian, Fedora, CentOS, RHEL tested)
- **Shell:** Bash (`/bin/bash`)
- **Dependencies:**
  - `python3` installed (for Script 2 to detect the package)
  - `rpm` or `dpkg` (Script 2, auto-detected)
  - `du`, `ls`, `awk`, `cut` — standard on all Linux systems
  - Readable log file for Script 4 (see above)

---

## License

This project is submitted as coursework. The shell scripts are original work by the student.
Python, the subject of analysis, is licensed under the [Python Software Foundation License](https://docs.python.org/3/license.html).
