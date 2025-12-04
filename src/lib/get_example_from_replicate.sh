get_example_from_replicate() {
  json=$(get_model_info "$model") || return 1

  jq --arg model "$model" \
    '{model: $model, input: .default_example.input}' \
    <<<"$json" |
    yq -P -
}
