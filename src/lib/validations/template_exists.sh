validate_template_exists() {
  if [[ ! -f "$templates_dir/$1.yaml" ]]; then
    echo "must be an existing template"
  fi
}
