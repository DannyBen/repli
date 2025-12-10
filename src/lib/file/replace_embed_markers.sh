replace_embed_markers() {
  local json="$1"
  local files=()
  local content

  # Find all "$(filename)" placeholders in JSON string values
  mapfile -t files < <(echo "$json" | jq -r '
    .. | select(type == "string") |
    match("^~(.+)$")? | .captures[0].string
  ')

  for file in "${files[@]}"; do
    if [[ ! -f "$file" ]]; then
      log error "embedded file not found: $(blue "$file")"
      return 1
    fi

    # Read raw file contents (preserve newlines)
    log debug "embedding $(blue "$file")"
    content=$(<"$file")

    # Use jq to replace the placeholder with file contents
    json=$(echo "$json" | jq \
      --arg placeholder "~$file" \
      --arg content "$content" \
      '(.. | select(type=="string" and .==$placeholder)) |= $content')

  done

  echo "$json"
}
