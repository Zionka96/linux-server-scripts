#!/bin/bash

LOG_FILE="/var/log/auth.log"
ALERT_LOG="/var/log/ssh_failures.log"
THRESHOLD=5

FAILS=$(grep "Failed password" "$LOG_FILE" | awk '{print $(NF-3)}' | sort | uniq -c | sort -nr)

echo "=== Failed SSH Logins: $(date) ===" >> "$ALERT_LOG"
echo "$FAILS" >> "$ALERT_LOG"
echo "" >> "$ALERT_LOG"
