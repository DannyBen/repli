get_model_info() {
  local model="$1"
  local body status

  # Capture body AND HTTP status code
  log debug calling replicate API
  body=$(curl -s -w "\n%{http_code}" \
    -H "Authorization: Bearer $REPLICATE_API_TOKEN" \
    "$replicate_host/v1/models/$model")

  # Split last line as status code, everything above is the JSON body
  status=$(tail -n1 <<<"$body")
  body=$(sed '$d' <<<"$body")

  # Any 4xx or 5xx status means error
  if [[ "$status" -ge 400 ]]; then
    log error "failed getting model info for $(blue "$model") (HTTP $status)"
    log error "$(jq -r '.detail // empty' <<<"$body")"
    return 1
  fi

  printf '%s\n' "$body"
}
