 #!/bin/bash

get_yaml_value() {
  key="$1"
  yaml_file="$2"
  yq eval ".$key" "$yaml_file"
}

BROKER=$(get_yaml_value "broker.host" "config/common.yaml")
PORT=$(get_yaml_value "broker.port" "config/common.yaml")
CLIENT_ID=$(get_yaml_value "device.client_id" "config/common.yaml")

NAME=$(get_yaml_value "module.name" "config/pulse_sensor.yaml")
TOPIC=$(get_yaml_value "module.topic" "config/pulse_sensor.yaml")
FREQUENCY=$(get_yaml_value "module.frequency" "config/pulse_sensor.yaml")
MIN=$(get_yaml_value "this.min" "config/pulse_sensor.yaml")
MAX=$(get_yaml_value "this.max" "config/pulse_sensor.yaml")
PRECISION=$(get_yaml_value "this.precision" "config/pulse_sensor.yaml")

get_random_value() {
#  echo $(( ( $RANDOM % ($MAX - $MIN + 1) ) + $MIN ))
    RANDOM_FLOAT=$(awk -v min="$MIN" -v max="$MAX" -v precision="$PRECISION" 'BEGIN { 
        srand(); 
        printf "%.*f\n", precision, min + (rand() * (max - min)); 
    }')

    echo "$RANDOM_FLOAT"
}

echo "Module $NAME"

while true
do
  MESSAGE=$(get_random_value)
  echo "Sending message to MQTT broker: $MESSAGE"
  mosquitto_pub -h "$BROKER" -p "$PORT" -t "$TOPIC" -m "pulse:$MESSAGE" -i "$CLIENT_ID" -q 2
  sleep $FREQUENCY
done
