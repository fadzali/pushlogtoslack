#!/bin/bash
# jazakallahukhair to amel farihe (abemat)
# Slack Incoming Webhook URL
WEBHOOK_URL="YOUR_WEBHOOK_URL"

# Log file to monitor
LOG_FILE="/usr/local/maldetect/logs/event_log"

# Keyword to search for in the log file
KEYWORD="quar"

# Function to send a message to Slack
send_slack_notification() {
  local message="$1"
  curl -s -d "payload={\"text\": \"${message}\"}" -X POST "${WEBHOOK_URL}"
}

# Main function to monitor the log file
monitor_log_file() {
  tail -n0 -F "$LOG_FILE" | while read line; do
    if [[ "$line" == *"$KEYWORD"* ]]; then
      # Keyword found in the log, send a Slack notification
      message="Keyword '${KEYWORD}' found in the log file: \n\`\`\`\n$line\n\`\`\`"
      send_slack_notification "$message"
    fi
  done
}

# Start monitoring the log file
monitor_log_file
