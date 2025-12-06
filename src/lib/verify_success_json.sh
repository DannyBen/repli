verify_success_json() {
  local json_file="$1"
  local status detail title invalid_fields

  if [[ ! -f "$json_file" ]]; then
    log error "file not found: $(blue "$json_file")"
    return 1
  fi

  status=$(jq -r '.status // empty' "$json_file")

  [[ "$status" == "succeeded" ]] && return 0
  log error "received invalid response:"
  yq -P -oy "$json_file"
  return 1
}
