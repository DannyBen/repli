cd ./test || exit 1
source approvals.bash

# clean templates dir
reset_state() {
  [[ "$(basename "$PWD")" == "test" ]] || exit 1

  blue_bold "  resetting state"
  rm -rf tmp
  mkdir tmp
  rm -f "$REPLI_OUTPUT_DIR"/{*.ini,*.json,repli.yaml,*.jpg,*.png}
}

# add dummy templates to the templates dir
add_templates() {
  blue_bold "  adding dummy templates"
  mkdir -p "$REPLI_TEMPLATES_DIR/nested"

  cp fixtures/templates/basic.yaml "$REPLI_TEMPLATES_DIR/model1.yaml"
  cp fixtures/templates/basic.yaml "$REPLI_TEMPLATES_DIR/model2.yaml"
  cp fixtures/templates/basic.yaml "$REPLI_TEMPLATES_DIR/another.yaml"
  cp fixtures/templates/basic.yaml "$REPLI_TEMPLATES_DIR/nested/upscaler.yaml"
}

add_repli_yaml() {
  blue_bold "  adding repli.yaml"
  cp fixtures/templates/basic.yaml "$REPLI_OUTPUT_DIR/repli.yaml"
}

editstub() {
  echo "editstub $*"
}

fzf() {
  # 1. Consume all input (the template list being piped in)
  cat >/dev/null

  # 2. Show debug info (stderr, does not affect stdout)
  : "${FZF_SELECT:=model1}"
  echo "fzf stub: selected=$FZF_SELECT args=$*" >&2

  # 3. Output the simulated selection (this becomes $template)
  printf '%s\n' "$FZF_SELECT"
}

initialize() {
  export REPLI_OUTPUT_DIR=tmp
  export REPLI_FILE=tmp/repli.yaml
  export REPLI_TEMPLATES_DIR=tmp/templates
  export REPLI_LOG_LEVEL=debug
  export REPLICATE_HOST=http://localhost:3000
  export REPLICATE_API_TOKEN=no-token-needed
  export EDITOR=editstub
  export -f editstub
  export -f fzf

  declare -g output_dir="$REPLI_OUTPUT_DIR"

  if [[ "$(curl -s ${REPLICATE_HOST}/ | jq -r '."mock server status"')" != "running" ]]; then
    fail "mock server not running, testing is aborted"
  fi

  if [[ "$(basename "$PWD")" != "test" ]]; then
    fail "invalid working dir: $PWD"
  fi
  
  reset_state
}

initialize
