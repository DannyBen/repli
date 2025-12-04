model="${args[model]}"
plain="${args[--plain]}"
example="${args[--example]}"
schema="${args[--schema]}"
json="${args[--json]}"
node="."

if [[ -n "$json" ]]; then
  parser="jq"
  opts=()
else
  parser="yq"
  opts=(-P)
fi

[[ -n "$example" ]] && node=".default_example.input"
[[ -n "$schema" ]] && node=".latest_version.openapi_schema.components.schemas.Input"
[[ -n "$plain" ]] && opts+=("-M")

get_model_info "$model" | "$parser" "${opts[@]}" "$node"
