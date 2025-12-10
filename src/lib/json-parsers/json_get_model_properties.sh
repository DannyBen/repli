## prints all model properties that have enum options
## input: a model info JSON
json_get_model_properties() {
  local json="$1"

  # iterate over properties
  while read -r prop; do
    enums=$(json_get_prop_enums "$json" "$prop")
    [[ -n "$enums" ]] || enums='*'
    echo "$prop: $enums"
  done < <(json_get_model_properties_list "$json")
}
