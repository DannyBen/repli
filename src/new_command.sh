search="${args[search]:-}"
outfile="${args[--output]}"
force="${args[--force]}"

log debug "models dir: $(blue "$models_dir")"

if [[ ! -d "$models_dir" ]]; then
  log error "no models in $(blue "$models_dir")"
  log info "change models dir using $(blue REPLI_MODELS_DIR)"
  return 1
fi

# Do not overwrite unless --force is used
if [[ -e "$outfile" && -z "$force" ]]; then
  log error "target already exists: $(blue "$outfile")"
  log info "use $(blue --force) to overwrite or $(blue --output PATH) to save to another file"
  return 1
fi

# Build match list using simple "contains" search
mapfile -t matches < <(
  find "$models_dir" -maxdepth 1 -type f -name "*.yaml" -printf "%f\n" |
    grep -i "${search:-.}"
)

# No matches
if [[ ${#matches[@]} -eq 0 ]]; then
  log error "no matching templates"
  return 1
fi

# Exactly one match → auto-select
if [[ ${#matches[@]} -eq 1 ]]; then
  selected="${matches[0]}"
else
  # Display simple numbered menu
  echo
  i=1
  for f in "${matches[@]}"; do
    echo " $i. ${f%.yaml}"
    ((i++))
  done

  echo
  read -rp "Choose a template (1-${#matches[@]}): " choice

  # Validate selection
  if ! [[ "$choice" =~ ^[0-9]+$ ]] || ((choice < 1 || choice > ${#matches[@]})); then
    log error "invalid selection"
    return 1
  fi

  selected="${matches[choice - 1]}"
fi

# Copy file (single place — no duplication)
log info "copying $(blue "$selected") → $(blue "$outfile")"
cp "$models_dir/$selected" "$outfile"
