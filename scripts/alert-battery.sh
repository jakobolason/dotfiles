#!/bin/sh

threshold=20  # threshold percentage to trigger alert
critical_threshold = 5
# Use `awk` to capture `acpi`'s percent capacity ($2) and status ($3) fields
# and read their values into the `status` and `capacity` variables
# uses grep because i somehow get two battery values?
acpi -b | grep 'Battery 1' | awk -F'[,:%]' '{print $2, $3}' | {
  read -r status capacity

  # If battery is discharging with capacity below threshold
  if [ "${status}" = Discharging -a "${capacity}" -lt ${threshold} ];
  then
    # Send a notification that appears for 300000 ms (5 min)
    notify-send -t 300000 "Battery level at ${capacity}!" "Charge your laptop soon"
  fi
}
