model="${args[model]}"
plain="${args[--plain]}"
example="${args[--example]}"
schema="${args[--schema]}"

node="."
[[ -n "$example" ]] && node=".default_example.input"
[[ -n "$schema" ]] && node=".latest_version.openapi_schema.components.schemas.Input"

jq_opts=()
[[ -n "$plain" ]] && jq_opts+=("-M")

get_model_info "$model" | jq "${jq_opts[@]}" "$node"


