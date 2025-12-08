## execute curl using a YAML config file
## usage: yurl request.yaml
yurl() {
  local yaml_file="$1"
  local model json

  # YAML validation
  if ! yq -e '.model' "$yaml_file" >/dev/null 2>&1; then
    log error "no model field in $(blue "$yaml_file")"
    return 1
  fi

  if ! yq -e '.input' "$yaml_file" >/dev/null 2>&1; then
    log error "no input field in $(blue "$yaml_file")"
    return 1
  fi

  # Get the model
  model=$(yq -r '.model' "$yaml_file")

  # Convert .input YAML → JSON
  json=$(yq -o=json '.input' "$yaml_file")

  # Replace any "<filename>" placeholders
  json=$(replace_file_placeholders "$json")

  # Replace any embedded "@filename" markers
  json=$(replace_embed_markers "$json")

  # Pipe the evaluated JSON to curl which uses it (@-) as its data.
  echo "$json" |
    jq '{input: .}' |
    curl -sS -X POST \
      -H "Authorization: Bearer $REPLICATE_API_TOKEN" \
      -H "Content-Type: application/json" \
      -H "Prefer: wait" \
      -d @- \
      "$replicate_host/v1/models/${model}/predictions"
}
