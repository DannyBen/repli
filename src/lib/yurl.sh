## execute curl using a YAML config file
## usage: yurl request.yaml
yurl() {
  local yaml_file="$1"
  local model version json payload url

  # YAML validation
  if ! yq -e '.input' "$yaml_file" >/dev/null 2>&1; then
    log error "no input field in $(blue "$yaml_file")"
    return 1
  fi

  model=$(yq -r '.model // ""' "$yaml_file")
  version=$(yq -r '.version // ""' "$yaml_file")

  if [[ -z "$model" && -z "$version" ]]; then
    log error "no model or version field in $(blue "$yaml_file")"
    return 1
  fi

  if [[ -n "$model" ]]; then
    url="$replicate_host/v1/models/${model}/predictions"
  else
    url="$replicate_host/v1/predictions"
  fi

  # Convert .input YAML → JSON and replace <filename> and ~filename.txt
  payload=$(yq -o=json '.' "$yaml_file")
  payload=$(replace_file_placeholders "$payload")
  payload=$(replace_embed_markers "$payload")

  # Pipe the evaluated JSON to curl which uses it (@-) as its data.
  echo "$payload" |
    curl -sS -X POST \
      -H "Authorization: Bearer $REPLICATE_API_TOKEN" \
      -H "Content-Type: application/json" \
      -H "Prefer: wait" \
      -d @- \
      "$url"
}
