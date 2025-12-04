## execute curl using a YAML config file
## usage: yurl request.yaml
yurl() {
  local yaml_file="$1"
  local model input_json final_json

  # Get the model
  model=$(yq -r '.model' "$yaml_file")

  # Convert .input YAML → JSON
  input_json=$(yq -o=json '.input' "$yaml_file")

  # Replace any "<filename>" placeholders
  final_json=$(replace_file_placeholders "$input_json")

  # Pipe the evaluated JSON to curl which uses it (@-) as its data.
  echo "$final_json" |
    jq '{input: .}' |
    curl -sS -X POST \
      -H "Authorization: Bearer $REPLICATE_API_TOKEN" \
      -H "Content-Type: application/json" \
      -H "Prefer: wait" \
      -d @- \
      "$replicate_host/v1/models/${model}/predictions"
}
