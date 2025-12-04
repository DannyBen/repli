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
    url=$(get_file_url "$file")
    json=$(echo "$json" | jq --arg f "<$file>" --arg u "$url" '
      (.. | select(type=="string" and .==$f)) |= $u
    ')
  done

  echo "$json"
}
