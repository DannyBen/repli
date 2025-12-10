## generates a template YAML from model info
## input: model info JSON
json_to_template() {
  json="$1"

  # Determine whether the model is official
  is_official=$(jq -r '.is_official // false' <<<"$json")

  echo "# https://replicate.com/$model"
  echo

  if [[ "$is_official" == "true" ]]; then
    log debug "model status: $(blue official)"
    # Official image
    jq --arg model "$model" \
      '{model: $model, input: .default_example.input}' \
      <<<"$json" | yq -P -
  else
    # Non-official image: use version instead of model
    log debug "model status: $(blue unofficial)"
    version=$(jq -r '.latest_version.id' <<<"$json")

    jq --arg model "$model" --arg version "$version" \
      '{version: ($model + ":" + $version), input: .default_example.input}' \
      <<<"$json" | yq -P -
  fi

  echo
  echo "# PROPERTIES"
  mapfile -t props < <(json_get_model_properties "$json")
  for propline in "${props[@]}"; do
    echo "# $propline"
  done
}
