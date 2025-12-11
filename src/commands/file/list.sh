local plain="${args[--plain]}"
local json="${args[--json]}"

if [[ -n "$json" ]]; then
  parser="jq"
  opts=()
else
  parser="yq"
  opts=(-P)
fi

[[ -n "$plain" ]] && opts+=("-M")
get_files_list | "$parser" "${opts[@]}" .results
