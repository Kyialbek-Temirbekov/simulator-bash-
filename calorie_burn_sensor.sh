 #!/bin/bash

get_yaml_value() {
  key="$1"
  yaml_file="$2"
  yq eval ".$key" "$yaml_file"
}

BROKER=$(get_yaml_value "broker.host" "config/common.yaml")
PORT=$(get_yaml_value "broker.port" "config/common.yaml")
CLIENT_ID=$(get_yaml_value "device.client_id" "config/common.yaml")

NAME=$(get_yaml_value "module.name" "config/calorie_burn_sensor.yaml")
BASE_TOPIC=$(get_yaml_value "module.topic" "config/calorie_burn_sensor.yaml")
TOPIC=$(echo "$BASE_TOPIC" | sed "s|+|$CLIENT_ID|")
FREQUENCY=$(get_yaml_value "module.frequency" "config/calorie_burn_sensor.yaml")
MIN=$(get_yaml_value "this.min" "config/calorie_burn_sensor.yaml")
MAX=$(get_yaml_value "this.max" "config/calorie_burn_sensor.yaml")
PRECISION=$(get_yaml_value "this.precision" "config/calorie_burn_sensor.yaml")

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
  mosquitto_pub -h "$BROKER" -p "$PORT" -t "$TOPIC" -m "$MESSAGE" -i "$CLIENT_ID" -q 2
  sleep $FREQUENCY
done
