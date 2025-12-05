if [[ ! -d "$templates_dir" ]]; then
  log error "templates dir not found: $(blue "$templates_dir")"
  log info "change templates dir using $(blue REPLI_TEMPLATES_DIR)"
  return 1
fi

echo "Templates in $(blue "$templates_dir"):"
echo

mapfile -d '' files \
  < <(find "$templates_dir" -maxdepth 1 -type f -name '*.yaml' -print0 | sort -z)

for file in "${files[@]}"; do
  basename "$file" .yaml
done
