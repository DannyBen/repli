local search="${args[search]}"
template="$(select_template "$search")"
file="$templates_dir/$template.yaml"
yq -P -oy "$file"

