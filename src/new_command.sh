search="${args[search]:-}"
outfile="${args[--output]}"
force="${args[--force]}"
models_dir="$REPLI_MODELS_DIR"

if [[ ! -d "$models_dir" ]]; then
  log error "models dir not found: $models_dir"
  log info "set models dir using REPLI_MODELS_DIR"
  return 1
fi

# Do not overwrite unless --force is used
if [[ -e "$outfile" && -z "$force" ]]; then
  log error "target already exists: $(blue "$outfile")"
  log info "use --force to overwrite"
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
  if ! [[ "$choice" =~ ^[0-9]+$ ]] || (( choice < 1 || choice > ${#matches[@]} )); then
    log error "invalid selection"
    return 1
  fi

  selected="${matches[choice-1]}"
fi

# Copy file (single place — no duplication)
log info "copying $(blue "$selected") → $(blue "$outfile")"
cp "$models_dir/$selected" "$outfile"
