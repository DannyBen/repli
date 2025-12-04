upload_to_replicate() {
  local input_file="$1"

  file=$(curl -s -X POST "https://api.replicate.com/v1/files" \
    -H "Authorization: Bearer $REPLICATE_API_TOKEN" \
    -H "Content-Type: multipart/form-data" \
    -F "content=@$input_file;type=application/octet-stream;title=$(basename $input_file)")
  
  input_file_url=$(echo "$file" | jq -r '.urls.get')
  echo "$input_file_url"
}