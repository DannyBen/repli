get_templates_list() {
  local search="${1:-.}" # optional search term

  find "$templates_dir" -maxdepth 1 -type f -name '*.yaml' -print0 |
    grep -iz "$search" |
    sort -zV |
    xargs -0 -n1 basename -s .yaml |
    tr '\n' '\0'
}
