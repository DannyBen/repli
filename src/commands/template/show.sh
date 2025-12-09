template="${args[template]}"
file="$templates_dir/$template.yaml"
yq -P -oy "$file"

