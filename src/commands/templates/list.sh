if [[ ! -d "$templates_dir" ]]; then
  log error "templates dir not found: $(blue "$templates_dir")"
  log info "change templates dir using $(blue REPLI_TEMPLATES_DIR)"
  return 1
fi

echo "Templates in $(blue "$templates_dir"):"
echo
for file in "$templates_dir"/*.yaml; do
  basename "$file" ".yaml"
done
