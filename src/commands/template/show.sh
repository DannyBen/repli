local search="${args[search]}"
template="$(select_template "$search")"
file="$templates_dir/$template.yaml"
if [[ -f "$file" ]]; then
  yq -P -oy "$file"
else
  log error "file not found $(blue "$file")"
fi

