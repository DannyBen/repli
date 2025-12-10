get_templates_list() {
  local search="${1:-}"

  while IFS= read -r -d '' rel; do
    # Strip .yaml
    local name="${rel%.yaml}"

    # If not nested, show only the basename
    if [[ "$rel" != */* ]]; then
      printf '%s\0' "$name"
    else
      # Keep the relative directory path
      printf '%s\0' "$name"
    fi

  done < <(
    find "$templates_dir" \
      -type f -name '*.yaml' \
      -printf '%P\0' | # <-- %P = path relative to $templates_dir
      grep -iz "$search" |
      sort -zV
  )
}
