# 🐧 Linux Server Automation Scripts

This is a collection of simple yet powerful Bash scripts I use to keep my personal Linux home server healthy, secure, and self-healing.

Each script solves a real-world sysadmin problem using basic tools like `cron`, `systemctl`, and `log parsing`.

---

## 📜 Included Scripts

### 🔐 ssh_watchdog.sh
Monitors `/var/log/auth.log` for failed SSH login attempts and logs them for later review.  
Helps track brute-force or suspicious login activity.

```bash
#!/bin/bash

LOG_FILE="/var/log/auth.log"
ALERT_LOG="/var/log/ssh_failures.log"

echo "=== Failed SSH Logins: $(date) ===" >> "$ALERT_LOG"
grep "Failed password" "$LOG_FILE" | awk '{print $(NF-3)}' | sort | uniq -c | sort -nr >> "$ALERT_LOG"
echo "" >> "$ALERT_LOG"
```

---

### 💾 disk_alert.sh
Checks if your storage (e.g., Plex media drive) exceeds a usage threshold (default: 85%).  
Sends an alert (or logs it) if the threshold is breached.

```bash
#!/bin/bash

THRESHOLD=85
USAGE=$(df /mnt/media | grep -v Filesystem | awk '{print $5}' | tr -d '%')

if [ "$USAGE" -gt "$THRESHOLD" ]; then
  echo "Warning: Media disk usage is at ${USAGE}%!" | mail -s "Storage Alert" you@example.com
fi
```

---

### 🎮 monitor_plex.sh
Checks if the Plex Media Server is running and restarts it automatically if it crashes or stops.  
Ensures constant uptime for media streaming.

```bash
#!/bin/bash

SERVICE="plexmediaserver"
if ! systemctl is-active --quiet $SERVICE; then
    echo "$(date): $SERVICE down, restarting..." >> /var/log/service_monitor.log
    systemctl restart $SERVICE
fi
```

---

## 🕒 Scheduling with Cron

Here’s a sample crontab configuration:

```cron
# Open with: crontab -e

# Run SSH login monitor every 6 hours
0 */6 * * * /home/zion/scripts/ssh_watchdog.sh >> /var/log/ssh_watchdog.log 2>&1

# Run disk alert at 3:15 AM
15 3 * * * /home/zion/scripts/disk_alert.sh >> /var/log/disk_alert.log 2>&1

# Check Plex every 15 minutes
*/15 * * * * /home/zion/scripts/monitor_plex.sh >> /var/log/monitor_plex.log 2>&1
```

---

## 🧠 Why I Built These

I'm training to become a professional Linux system administrator and built these scripts as part of my home server automation journey.

They help me:
- Reduce downtime
- Increase security
- Learn real-world skills through practice

---
