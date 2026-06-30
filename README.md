# Server Statistics CLI Tool (`server-stat`)

A lightweight, pure Bash utility designed to provide quick and comprehensive insights into your server's current health, system load, resource utilization, and top demanding processes.

---

## Features

- **User Monitoring:** Displays active users currently connected to the network.
- **System Load:** Shows standard Load Average intervals (1m, 5m, 15m).
- **CPU Metrics:** Calculates real-time total CPU utilization percentage.
- **Memory Analytics:** Detailed RAM stats displaying used and free memory in MB along with percentages.
- **Storage Overview:** Monitors disk space usage on the root partition (`/`) in GB and percentages.
- **Process Profiling:** Lists the **Top 5 processes** consuming the most CPU and Memory resources.
- **Colorized Interface:** Uses clear, high-contrast terminal colors for optimal readability.

---

## Prerequisites

To run this tool and compute all advanced statistics correctly, your Linux environment requires the following utilities available (standard on most distributions):
- `bash` (version 4.0 or higher)
- `awk`, `sed`, `grep`
- `bc` (for precise floating-point mathematical calculations)
- `top`, `free`, `df`, `uptime`, `ps`
- `make` and `sudo` privileges (only required for system-wide installation)

---

## Installation & Uninstallation

The project includes a `Makefile` to quickly set up or remove the utility globally.

### Installation

Run the following command to copy the script to `/usr/local/bin` and automatically grant executable permissions (working only in project directory):

```bash
make install```

### Uninstallation

If you wish to cleanly remove the application and its binaries from your system (working only in project directory):

```bash
make uninstall```

## Usage

If you installed the script globally, use server-stat. If you are running it directly from the local repository directory, use ./server-stat.sh.

### Options

Add option after command to:
  -h, --help    Display the interactive help menu and exits.
  -v, --version    Display the current script version and exits.
  -s, --start    Run the script to gather and display server metrics.

## Running the Script

To output the live server dashboard metrics, execute:
  server-stat --start
Alternative (Local Repository):
  ./server-stat.sh --start

## Example Output

When running server-stat --start, you will see a neatly formatted interface resembling the following layout:
--------------------------------------Users--------------------------------------
Users in network:
  username pts/0        2026-06-30 14:22 (192.168.1.5)

---------------------------------Server statistics--------------------------------
Load average:
  1m: 0.15 5m: 0.08 15m: 0.02

CPU usage:
  Used: 12.4%

MEM usage:
  Used: 3120 MB/8192 MB (38.0%)
  Free: 5072 MB/8192 MB (62.0%)

DISK usage:
  Used: 45 GB/100 GB (45.0%)
  Free: 55 GB/100 GB (55.0%)

Top 5 processes by CPU usage:
   PID CMD                         %CPU %MEM
  1234 /usr/lib/firefox/firefox    15.2  4.1
  5678 /usr/bin/dockerd             4.5  1.8
  ...

Top 5 processes by MEM usage:
   PID CMD                         %CPU %MEM
  9101 /usr/bin/java -jar app.jar   1.2 12.5
  1234 /usr/lib/firefox/firefox    15.2  4.1
  ...
--------------------------------------------------------------------------------

## Error Handling

The script includes built-in parameter validations. Failing to supply an argument or inputting an invalid parameter will terminate execution with a specific status exit code (1) and output helpful guidance:

## License

This project is open-source and available under the MIT License.
