config="${args[--config]}"
prefix="${args[prefix]:-$(get_unique_filename "$(basename "$repli_file" ".yaml")")}"
outfile="${prefix}.json"
log debug config: "$(blue "$config")"
log debug prefix: "$(blue "$prefix")"
log debug outfile: "$(blue "$outfile")"

# call API unless the JSON is already saved
if [[ -f "$outfile" ]]; then
  log info skipping API call, file exists: "$(blue "$outfile")"
else
  log info calling API and saving "$(blue "$outfile")"
  yurl "$config" >"$outfile"
fi

# download outputs
download_outputs "$prefix" "$outfile"
