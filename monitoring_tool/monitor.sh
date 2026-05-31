#!/usr/bin/env bash

# Load config
source ./config.sh

# Ensure logs directory exists
mkdir -p ./logs

# Default values
process=""
logfile=""

# -------------------------------
# Logging Function
# -------------------------------
log_message() {
    local level="$1"
    local message="$2"
    echo "$(date '+%Y-%m-%d %H:%M:%S') [$level] : $message" >> "$LOG_FILE"
}

# -------------------------------
# Parse CLI Arguments
# -------------------------------
while getopts "p:l:" opt
do
    case $opt in
        p) process=$OPTARG ;;
        l) logfile=$OPTARG ;;
        *) echo "Usage: $0 -p process -l logfile"
           exit 1 ;;
    esac
done

# -------------------------------
# Process Monitoring
# -------------------------------
check_process() {
    local process="$1"

    count=$(pgrep -xc "$process")

    if [[ $count -gt 0 ]]
    then
        log_message "INFO" "Process '$process' is running ($count instances)"
    else
        log_message "ERROR" "Process '$process' is NOT running"
        log_message "ERROR" "ALERT: Immediate attention required"
    fi
}

# -------------------------------
# Disk Monitoring
# -------------------------------
check_disk() {
    usage=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')

    if [[ $usage -ge $DISK_CRITICAL ]]
    then
        log_message "ERROR" "CRITICAL: Disk usage is $usage%"
    elif [[ $usage -ge $DISK_WARNING ]]
    then
        log_message "WARNING" "Disk usage is high: $usage%"
    else
        log_message "INFO" "Disk usage is normal: $usage%"
    fi
}

# -------------------------------
# Log Analyzer
# -------------------------------
check_logs() {
    local logfile="$1"

    if [[ ! -f "$logfile" ]]
    then
        log_message "ERROR" "Log file '$logfile' not found"
        return
    fi

    total_lines=$(wc -l < "$logfile")
    error_count=$(grep -i -c "error" "$logfile")
    warning_count=$(grep -i -c "warning" "$logfile")

    log_message "INFO" "Analyzing log file: $logfile"
    log_message "INFO" "Total lines: $total_lines"
    log_message "INFO" "Errors: $error_count"
    log_message "INFO" "Warnings: $warning_count"

    # Error alert logic
    if [[ $error_count -gt 10 ]]
    then
        log_message "ERROR" "High error count detected: $error_count"
    elif [[ $error_count -gt 0 ]]
    then
        log_message "WARNING" "Some errors found: $error_count"
    else
        log_message "INFO" "No errors found"
    fi

    # Show last 5 lines
    log_message "INFO" "Last 5 lines of log file:"
    tail -n 5 "$logfile" >> "$LOG_FILE"
}

# -------------------------------
# Main Function
# -------------------------------
main() {

    if [[ -z "$process" && -z "$logfile" ]]
    then
        echo "Provide at least one option: -p or -l"
        exit 1
    fi

    log_message "INFO" "----------------------------------------"
    log_message "INFO" "Monitoring script started"
    log_message "INFO" "User: $(whoami)"
    log_message "INFO" "System: $(uname -a)"

    [[ -n "$process" ]] && check_process "$process"
    check_disk
    [[ -n "$logfile" ]] && check_logs "$logfile"

    log_message "INFO" "Monitoring finished"
}

main
