show_templates_list() {
  local search="${1:-.}" # optional search term

  echo "Templates in $(blue "$templates_dir"):"
  echo

  mapfile -d '' templates < <(get_templates_list "$search")

  i=1
  for f in "${templates[@]}"; do
    echo " $i. $f"
    ((i++))
  done

  echo
}