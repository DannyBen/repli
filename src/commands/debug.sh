


model="google/nano-banana"
json=$(get_model_info "$model") || return 1
# get_example_from_replicate "$model"

mapfile -t lines < <(json_get_model_properties "$json")

for line in "${lines[@]}"; do
  echo "==> $line"
done
