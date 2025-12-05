model="${args[model]}"
name="${args[--name]}"
force="${args[--force]}"

[[ "$name" == "auto" ]] && name="${model#*/}"

outpath="$templates_dir/$name.yaml"

if [[ -f "$outpath" && ! "$force" ]]; then
  log debug "target: $(blue "$outpath")"
  log error "target already exists: $(blue "$name")"
  log info "use $(blue --force) to overwrite or $(blue --output NAME) to save with another name"
  return 1
fi

log info "saving to $(blue "$outpath")"
mkdir -p "$templates_dir"
get_example_from_replicate "$model" >"$outpath"
