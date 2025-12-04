get_model_info() {
  model="$1"

  curl -s -H "Authorization: Bearer $REPLICATE_API_TOKEN" "$replicate_host/v1/models/$model"
}
