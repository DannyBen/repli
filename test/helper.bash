cd ./test || exit 1
source approvals.bash

# clean templates dir
reset_state() {
  [[ "$(basename "$PWD")" == "test" ]] || exit 1

  blue_bold "  resetting state"
  rm -rf tmp
  mkdir tmp
  rm -f files.ini
  rm -f repli.yaml
}

# add dummy templates to the templates dir
add_templates() {
  count="${1:-1}"
  blue_bold "  adding $count dummy templates"
  mkdir -p tmp/templates

  for i in $(seq 1 "$count"); do
    cp fixtures/template.yaml "tmp/templates/model${i}.yaml"
  done
}

add_repli_yaml() {
  blue_bold "  adding repli.yaml"
  cp fixtures/template.yaml repli.yaml
}

initialize() {
  export REPLICATE_HOST=http://localhost:3000
  export REPLICATE_API_TOKEN=no-token-needed
  export REPLI_TEMPLATES_DIR=tmp/templates
  export REPLI_LOG_LEVEL=debug

  if [[ "$(curl -s ${REPLICATE_HOST}/ | jq -r '."mock server status"')" != "running" ]]; then
    fail "mock server not running, testing is aborted"
  fi

  if [[ "$(basename "$PWD")" != "test" ]]; then
    fail "invalid working dir: $PWD"
  fi
  
  reset_state
}

initialize
