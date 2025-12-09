select_template() {
  local search="$1"
  local exact="$2"

  # Get templates list matching the search
  mapfile -d '' templates < <(get_templates_list "$search")

  # No matches
  if [[ ${#templates[@]} -eq 0 ]]; then
    log error "no matching templates"
    return 1
  fi

  if [[ ${#templates[@]} -eq 1 ]]; then
    # Exactly one match → auto-select
    echo "${templates[0]}"
    return
  else
    # Show interactive menu
    show_templates_list "$search" >&2

    if [[ "$exact" ]]; then
      log error "no exact match"
      return 1
    fi

    read -rp "Choose a template (1-${#templates[@]}): " choice

    # Validate selection
    if ! [[ "$choice" =~ ^[0-9]+$ ]] || ((choice < 1 || choice > ${#templates[@]})); then
      log error "invalid selection"
      return 1
    fi

    echo "${templates[choice - 1]}"
  fi
}