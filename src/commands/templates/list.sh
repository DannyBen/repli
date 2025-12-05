search="${args[search]}"

if [[ ! -d "$templates_dir" ]]; then
  log error "templates dir not found: $(blue "$templates_dir")"
  log info "change templates dir using $(blue REPLI_TEMPLATES_DIR)"
  return 1
fi

show_templates_list "$search"
