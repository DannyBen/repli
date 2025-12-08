replace_file_placeholders() {
  local json="$1"
  local url
  local files=()

  # Find all "<filename>" occurrences in JSON values
  mapfile -t files < <(echo "$json" | jq -r '
    .. | select(type == "string") |
    match("^<(.+)>$")? | .captures[0].string
  ')

  # Replace each placeholder with uploaded file URL
  for file in "${files[@]}"; do
    if [[ ! -f "$file" ]]; then
      log error "upload file not found: $(blue "$file")"
      return 1
    fi

    log debug "replacing upload file marker $(blue "$file")"
    url=$(get_file_url "$file")
    json=$(echo "$json" | jq --arg f "<$file>" --arg u "$url" '
      (.. | select(type=="string" and .==$f)) |= $u
    ')
  done

  echo "$json"
}
