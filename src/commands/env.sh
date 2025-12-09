printf "REPLI_FILE:           %s\n" "$(yellow "$REPLI_FILE")"
[[ -f "$REPLI_FILE" ]] && msg=$(green found) || msg=$(red "NOT FOUND")
printf "REPLI_FILE status:    %s\n" "$msg"
printf "REPLI_OUTPUT_DIR:     %s\n" "$(yellow "$output_dir")"
printf "REPLI_TEMPLATES_DIR:  %s\n" "$(yellow "$templates_dir")"
printf "REPLI_LOG_LEVEL:      %s\n" "$(yellow "$log_level")"
printf "REPLICATE_HOST:       %s\n" "$(yellow "$replicate_host")"

if [[ -z "$REPLICATE_API_TOKEN" ]]; then
  msg=$(red "NOT SET")
else
  msg="$(printf "%s...%s" "${REPLICATE_API_TOKEN:0:3}" "${REPLICATE_API_TOKEN: -3}")"
  msg="$(yellow "$msg")"
fi

printf "REPLICATE_API_TOKEN:  %s\n" "$msg"
