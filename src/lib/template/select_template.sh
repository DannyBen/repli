select_template() {
  local search="$1"

  ( get_templates_list "$search" | fzf --select-1 --exit-0 ) || true
}