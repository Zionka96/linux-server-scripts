#!/bin/bash

SERVICE="plexmediaserver"
if ! systemctl is-active --quiet $SERVICE; then
    echo "$(date): $SERVICE down, restarting..." >> /var/log/service_monitor.log
    systemctl restart $SERVICE
fi
