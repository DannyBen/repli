#!/usr/bin/env bash
describe "get"
  reset_state
  approve "repli get --help"
  approve "repli get" "repli get@no_repli_yaml"
  add_repli_yaml
  approve "repli get x"

  # ensure the downloaded file matches the source file
  [[ "$(stat -c%s $output_dir/x_out-0.jpg)" -eq "$(stat -c%s mockserver/mocks/assets/out-0.jpg)" ]] ||
    fail "downloaded file does not match the source file"
  
  approve "repli get x" "repli_get_x@again"

  context "error condition"
    cp 'fixtures/templates/error.yaml' "$output_dir/repli.yaml"
    approve "repli get" "repli_get@error"

  context "embed and upload files"
    reset_state
    approve "repli get -u fixtures/templates/files.yaml"

