get_file_url() {
  local file="$1"
  local files_list="files.ini"

  if [[ -f "$files_list" ]]; then
    log debug reading files list: "$(blue "$files_list")"

    while IFS='=' read -r path url; do
      if [[ "$path" == "$file" ]]; then
        log debug file already registered in "$(blue "$files_list")"
        log debug "$file → $url"
        echo "$url"
        return
      fi
    done < "$files_list"
  fi

  log info uploading file: "$(blue "$file")"
  url="$(upload_to_replicate "$file")"
  log debug file url: "$(underlined "$url")"
  log debug saving URL to "$(blue "$files_list")"
  echo "$file=$url" >> "$files_list"
  echo "$url"
}
