#!/bin/bash

get_yaml_value() {
  key="$1"
  yaml_file="$2"
  yq eval ".$key" "$yaml_file"
}

BROKER=$(get_yaml_value "broker.host" "config/common.yaml")
PORT=$(get_yaml_value "broker.port" "config/common.yaml")
CLIENT_ID=$(get_yaml_value "device.client_id" "config/common.yaml")

NAME=$(get_yaml_value "module.name" "config/monitor.yaml")
BASE_TOPIC=$(get_yaml_value "module.topic" "config/monitor.yaml")
TOPIC=$(echo "$BASE_TOPIC" | sed "s|+|$CLIENT_ID|")

mosquitto_sub -h "$BROKER" -p "$PORT" -t "$TOPIC" -q 1 -v
