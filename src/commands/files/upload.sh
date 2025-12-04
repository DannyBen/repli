file="${args[file]}"
files_list="files.ini"

if [[ -f "$files_list" ]]; then
  log debug reading files list: "$(blue "$files_list")"

  while IFS='=' read -r path url; do
    if [[ "$path" == "$file" ]]; then
      log info upload skipped, already registered in "$(blue "$files_list")"
      log info url: "$url"
      return 0
    fi
  done <"$files_list"
fi

log info uploading "$(blue "$file")"
url="$(upload_to_replicate "$file")"
log info url: "$(underlined "$url")"

log info saving URL to "$(blue "$files_list")"
echo "$file=$url" >>"$files_list"
