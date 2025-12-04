model="${args[model]}"
name="${args[name]}"
force="${args[--force]}"

if [[ -z "$name" ]]; then
  get_example_from_replicate "$model"
  return 0
fi

outpath="$models_dir/$name.yaml"

if [[ -f "$outpath" && ! "$force" ]]; then
  log error "target already exists: $(blue "$outpath")"
  log info "use --force to overwrite"
  return 1
fi

log info "saving to $(blue "$outpath")"
mkdir -p "$models_dir"
get_example_from_replicate "$model" > "$outpath"


