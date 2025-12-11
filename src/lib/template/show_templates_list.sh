show_templates_list() {
  local search="${1:-.}"

  echo "Templates in $(blue "$templates_dir"):"
  echo

  # Capture the list (newline-delimited)
  local list
  list=$(get_templates_list "$search")

  if [[ -z "$list" ]]; then
    echo "  No templates found."
    echo
    return
  fi

  # Print numbered list
  printf '%s\n' "$list" | nl -w3 -s'. '

  echo
}
