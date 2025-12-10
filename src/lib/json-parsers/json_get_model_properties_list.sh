## returns an array of all input properties from the JSON schema
## input: model info JSON
json_get_model_properties_list() {
  local json="$1"

  echo "$json" | jq -r '
    .latest_version.openapi_schema.components.schemas.Input.properties
    | keys[]
  '
}
