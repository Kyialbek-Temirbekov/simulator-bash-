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
TOPIC=$(get_yaml_value "module.topic" "config/monitor.yaml")

echo "Module $NAME"

mosquitto_sub -h "$BROKER" -p "$PORT" -t "$TOPIC" -q 1 -c -i "$CLIENT_ID" | while read -r MESSAGE
do
    clear
    echo $MESSAGE
done
