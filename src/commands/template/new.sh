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
log info "building template for $(blue "$model")"
json=$(get_model_info "$model") || return 1
template="$(json_to_template "$json")"
if [[ -n "$template" ]]; then
  log info "saving to $(blue "$outpath")"
  printf "%s\n" "$template" >"$outpath"
else
  log error "received an empty template"
fi

