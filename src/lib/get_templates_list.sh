get_templates_list() {
  local search="${1:-.}" # optional search term

  while IFS= read -r -d '' file; do
    basename -s .yaml "$file"
  done < <(
    find "$templates_dir" -maxdepth 1 -type f -name '*.yaml' -print0 |
      grep -iz "$search" |
      sort -zV
  ) | tr '\n' '\0'
}
