#!/bin/bash

THRESHOLD=85
USAGE=$(df /mnt/media | grep -v Filesystem | awk '{print $5}' | tr -d '%')

if [ "$USAGE" -gt "$THRESHOLD" ]; then
  echo "Warning: Media disk usage is at ${USAGE}%!" | mail -s "Storage Alert" you@example.com
fi
