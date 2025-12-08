#!/usr/bin/env bash
describe "get"
  reset_state
  approve "repli get --help"
  approve "repli get" "repli get@no_repli_yaml"
  add_repli_yaml
  approve "repli get tmp/get"

  # ensure the downloaded file matches the source file
  [[ "$(stat -c%s tmp/get_out-0.jpg)" -eq "$(stat -c%s mockserver/mocks/assets/out-0.jpg)" ]] ||
    fail "downloaded file does not match the source file"
  
  approve "repli get tmp/get" "repli_get_tmp_get@again"

  context "error condition"
    cp 'fixtures/error_template.yaml' repli.yaml
    approve "repli get" "repli_get_error"

  context "embed files"
    reset_state
    approve "repli get -u fixtures/files_template.yaml"

