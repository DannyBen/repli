## execute curl using a YAML config file
## usage: yurl request.yaml
yurl() {
  local yaml_file="$1"

  local model

  # Get model from the YAML
  model=$(yq -r '.model' "$yaml_file")

  # Get the input node from teh YAML, pipe it to jq to convert it to JSON,
  # then pipe it to curl which uses it (@-) as its data.
  yq -o=json '.input' "$yaml_file" \
    | jq '{input: .}' \
    | curl -sS -X POST \
      -H "Authorization: Bearer $REPLICATE_API_TOKEN" \
      -H "Content-Type: application/json" \
      -H "Prefer: wait" \
      -d @- \
      "https://api.replicate.com/v1/models/${model}/predictions"
}
