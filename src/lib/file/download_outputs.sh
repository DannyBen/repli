# usage: download_outputs PREFIX json_file
download_outputs() {
  local prefix="$1"
  local json_file="$2"
  local filename

  if [[ ! -f "$json_file" ]]; then
    log error file not found: "$(blue "$json_file")"
    return 1
  fi

  # Extract URLs (string → array, array → array)
  readarray -t urls < <(
    jq -r '
      (.output | if type=="string" then [.] else . end)
      | .[]
    ' "$json_file"
  )

  if [[ ${#urls[@]} -eq 0 || "${urls[0]}" == "null" ]]; then
    log warn no outputs found in "$(blue "$json_file")"
    return 0
  fi

  for url in "${urls[@]}"; do
    filename="${output_dir}/${prefix}_$(basename "$url")"

    if [[ -f "$filename" ]]; then
      log info "skipping download, file exists: $(blue "$filename")"
      continue
    fi

    log debug "downloading from: $(underlined "$url")"
    log info "downloading to $(blue "$filename")"

    wget -q -O "$filename" "$url" ||
      log error "failed to download: $(underlined "$url")"

  done
}
