describe "edit"
  reset_state
  approve "repli edit --help"
  approve "repli edit" "repli_edit@empty"
  add_repli_yaml
  approve "repli edit"
  mv "$output_dir/repli.yaml" "$output_dir/custom.yaml"
  approve "repli edit -u $output_dir/custom.yaml"
  rm "$output_dir/custom.yaml"

