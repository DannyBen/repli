## Search for existing files matching base-N*
## args: prefix
get_unique_filename() {
  local base="$1"
  local max=0
  local n

  for f in "${base}-"*; do
    [[ -e "$f" ]] || continue # skip if no match

    if [[ $f =~ ${base}-([0-9]+) ]]; then
      n="${BASH_REMATCH[1]}"
      ((n > max)) && max="$n"
    fi
  done

  echo "${base}-$((max + 1))"
}
