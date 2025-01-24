#!/bin/bash

get_yaml_value() {
  key="$1"
  yaml_file="$2"
  yq eval ".$key" "$yaml_file"
}

MODEL=$(get_yaml_value "device.model" "config/common.yaml")
VERSION=$(get_yaml_value "device.version" "config/common.yaml")
echo "Started application 'Smart watch simulator'"
echo "Device $MODEL $VERSION"

GPS_SENSOR_COMMAND="bash gps_sensor.sh"
gnome-terminal --title="GPS SENSOR" -- bash -c "$GPS_SENSOR_COMMAND; exec bash"

MONITOR_COMMAND="bash monitor.sh"
gnome-terminal --title="MONITOR" -- bash -c "$MONITOR_COMMAND; exec bash"

CALORIE_BURN_SENSOR_COMMAND="bash calorie_burn_sensor.sh"
gnome-terminal --title="CALORIE BURN SENSOR" -- bash -c "$CALORIE_BURN_SENSOR_COMMAND; exec bash"

STEP_COUNT_SENSOR_COMMAND="bash step_count_sensor.sh"
gnome-terminal --title="STEP COUNT SENSOR" -- bash -c "$STEP_COUNT_SENSOR_COMMAND; exec bash"

PULSE_SENSOR_COMMAND="bash pulse_sensor.sh"
gnome-terminal --title="PULSE SENSOR" -- bash -c "$PULSE_SENSOR_COMMAND; exec bash"

SATURATION_SENSOR_COMMAND="bash saturation_sensor.sh"
gnome-terminal --title="SATURATION SENSOR" -- bash -c "$SATURATION_SENSOR_COMMAND; exec bash"

AIR_QUALITY_SENSOR_COMMAND="bash air_quality_sensor.sh"
gnome-terminal --title="AIR QUALITY SENSOR" -- bash -c "$AIR_QUALITY_SENSOR_COMMAND; exec bash"
