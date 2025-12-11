get_templates_list() {
  local search="${1:-}"

  find "$templates_dir" \
    -type f -name '*.yaml' \
    -printf '%P\n' \
    | { grep -i "$search" || true; } \
    | sort -V \
    | sed 's/\.yaml$//'
}
