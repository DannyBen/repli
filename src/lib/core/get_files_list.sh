## Get uploaded files list from replicate
get_files_list() {
  curl -s -H "Authorization: Token $REPLICATE_API_TOKEN" "$replicate_host/v1/files"
}
