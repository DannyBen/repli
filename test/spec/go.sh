#!/usr/bin/env bash
describe "go"
  reset_state
  approve "repli go --help"
  approve "repli go" "repli go@no_repli_yaml"
  add_repli_yaml
  approve "repli go x"

  # ensure the downloaded file matches the source file
  [[ "$(stat -c%s $output_dir/x_out-0.jpg)" -eq "$(stat -c%s mockly/assets/out-0.jpg)" ]] ||
    fail "downloaded file does not match the source file"
  
  approve "repli go x" "repli_go_x@again"

  context "error condition"
    cp 'fixtures/templates/error.yaml' "$output_dir/repli.yaml"
    approve "repli go" "repli_go@error"

  context "embed and upload files"
    reset_state
    approve "repli go -u fixtures/templates/files.yaml"

