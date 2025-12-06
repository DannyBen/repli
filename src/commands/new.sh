search="${args[search]}"
outfile="${args[--use]}"
force="${args[--force]}"
exact="${args[--exact]}"

# Do not overwrite unless --force is used
if [[ -e "$outfile" && -z "$force" ]]; then
  log error "target already exists: $(blue "$outfile")"
  log info "use $(blue --force) to overwrite or $(blue --output PATH) to save to another file"
  return 1
fi

# Get templates list matching the search
mapfile -d '' templates < <(get_templates_list "$search")

# No matches
if [[ ${#templates[@]} -eq 0 ]]; then
  log error "no matching templates"
  return 1
fi

if [[ ${#templates[@]} -eq 1 ]]; then
  # Exactly one match → auto-select
  selected="${templates[0]}"
else
  # Show interactive menu
  show_templates_list "$search"

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

  selected="${templates[choice - 1]}"
fi

# Copy file
infile="${templates_dir}/${selected}.yaml"
log info "copying $(blue "$infile") → $(blue "$outfile")"
cp "$infile" "$outfile"
