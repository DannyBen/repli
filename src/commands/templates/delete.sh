template="${args[template]}"
file="$templates_dir/$template.yaml"
log info "deleting $file"
rm "$file"
