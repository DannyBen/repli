filter_templates_dir_exists() {
  if [[ ! -d "$templates_dir" ]]; then
    echo "Templates dir not found ($templates_dir), set using REPLI_TEMPLATES_DIR"
  fi
}
