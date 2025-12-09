local model="${args[model]}"
local name="${args[--name]}"
local force="${args[--force]}"

[[ "$name" == "auto" ]] && name="${model#*/}"

outpath="$templates_dir/$name.yaml"

if [[ -f "$outpath" && ! "$force" ]]; then
  log debug "target: $(blue "$outpath")"
  log error "target already exists: $(blue "$name")"
  log info "use $(blue --force) to overwrite or $(blue --output NAME) to save with another name"
  return 1
fi

mkdir -p "$templates_dir"
log debug "fetching example for $(blue "$model")"
template="$(get_example_from_replicate "$model")"

log info "saving to $(blue "$outpath")"
[[ -n "$template" ]] && printf "%s\n" "$template" >"$outpath"
