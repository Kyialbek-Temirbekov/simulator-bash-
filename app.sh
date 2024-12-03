#!/bin/bash

get_yaml_value() {
  key="$1"
  yaml_file="$2"
  yq eval ".$key" "$yaml_file"
}

MODEL=$(get_yaml_value "device.model" "config/common.yaml")
VERSION=$(get_yaml_value "device.version" "config/common.yaml")
echo "Started application SMART WATCH"
echo "Device $MODEL $VERSION"

PULSE_SENSOR_COMMAND="bash pulse_sensor.sh"
gnome-terminal --title="PULSE SENSOR" -- bash -c "$PULSE_SENSOR_COMMAND; exec bash"

MONITOR_COMMAND="bash monitor.sh"
gnome-terminal --title="MONITOR" -- bash -c "$MONITOR_COMMAND; exec bash"
