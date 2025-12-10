## returns a space delimited string of allowed enum values for a property
## input: model info JSON, property name
json_get_prop_enums() {
  local json="$1"
  local prop="$2"

  echo "$json" | jq -r --arg prop "$prop" '
    .latest_version.openapi_schema.components.schemas[$prop]
    | .. | objects | select(has("enum")) | .enum? // empty
    | join(", ")
  '
}
