local search="${args[search]}"
local outfile="${args[--use]}"
local force="${args[--force]}"
local exact="${args[--exact]}"

# Do not overwrite unless --force is used
if [[ -e "$outfile" && -z "$force" ]]; then
  log error "target already exists: $(blue "$outfile")"
  log info "use $(blue --force) to overwrite or $(blue --output PATH) to save to another file"
  return 1
fi

selected="$(select_template "$search" "$exact")"

# Copy file
infile="${templates_dir}/${selected}.yaml"
log info "copying $(blue "$infile") → $(blue "$outfile")"
cp "$infile" "$outfile"
