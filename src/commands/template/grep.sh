local search="${args[search]}"

echo "Templates: $(blue "$templates_dir")"
echo "Search:    $(green "$search")"
echo

grep -Ril --include="*.yaml" "$search" "$templates_dir" |
  sed -e "s|^$templates_dir/||" -e 's/\.yaml$//'


