# Linux System Monitoring Tool (Bash)

A lightweight **Bash-based system monitoring tool** that helps track system health by analyzing processes, disk usage, and logs. Designed with **real-world DevOps practices** like logging, automation, and error handling.

---

## Features

* **Process Monitoring**

  * Check if a specific process is running
* **Disk Usage Monitoring**

  * Alerts if disk usage crosses threshold
* **Log Analysis**

  * Counts errors and warnings in log files
* **CLI Support**

  * Pass arguments using flags
* **Logging System**

  * Structured logs with timestamps (INFO, WARNING, ERROR)
* **Automation Ready**

  * Can be scheduled using cron
* **Safe Script Execution**

  * Uses `set -euo pipefail` for reliability

---

## Tech Stack

* Bash Scripting
* Linux Commands (`grep`, `awk`, `df`, `pgrep`, etc.)

---

## Project Structure

```
monitoring_tool/
│
├── monitor.sh          # Main script
├── logs/
│   └── monitor.log     # Log file
├── config.sh           # Configuration file (optional)
└── README.md
```

---

##  How to Run

### 1. Give Execute Permission

```bash
chmod +x monitor.sh
```

---

### 2. Run Script

```bash
./monitor.sh -p <process_name> -l <log_file>
```

---

### Example:

```bash
./monitor.sh -p nginx -l logs/app.log
```

---

##  Script Options

| Flag | Description             |
| ---- | ----------------------- |
| `-p` | Process name to monitor |
| `-l` | Log file to analyze     |

---

##  Example Output

```
[INFO] Monitoring started
[INFO] Process nginx is running
[WARNING] Disk usage is above threshold
[ERROR] Found 5 errors in log file
```

---

##  Automation (Cron Job)

Run script daily at 10 AM:

```bash
crontab -e
```

Add:

```bash
0 10 * * * /path/to/monitor.sh >> /path/to/logs/cron.log 2>&1
```

---

##  Key Concepts Used

* Bash scripting fundamentals
* Process monitoring (`pgrep`)
* Disk usage (`df`)
* Log parsing (`grep`, `wc`)
* Error handling (`set -euo pipefail`)
* Output redirection
* Cron automation
* Debugging techniques

---

##  Learning Outcomes

* Built a real-world **DevOps-style monitoring tool**
* Learned **safe and robust Bash scripting**
* Understood **Linux internals (processes, logs, filesystem)**
* Applied **automation and debugging strategies**

---

##  Future Improvements

* Add email/Slack alerts 
* Support JSON log parsing (`jq`)
* Integrate with Docker/Kubernetes
* Add threshold configuration file

---

## ⭐ If you like this project

Give it a ⭐ on GitHub and feel free to contribute!
