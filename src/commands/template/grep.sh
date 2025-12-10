local search="${args[search]}"

echo "Templates: $(blue "$templates_dir")"
echo "Search:    $(green "$search")"
echo

(
  cd "$templates_dir" >/dev/null || return 1

  find . \
    -type f -name '*.yaml' \
    -printf '%P\0' |
    xargs -0 grep -ilZ "$search" |
    sed -z 's/\.yaml$//' |
    sort -zV |
    tr '\0' '\n'
)
