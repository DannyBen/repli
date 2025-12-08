describe "new"
  reset_state
  add_templates
  approve "repli new --help"
  approve "repli new model1"
  approve "repli new model1" "repli_new_model1@again"
  approve "repli new model1 --force"
  approve "repli new model1 --use $output_dir/renamed.yaml"
  approve "cat $output_dir/repli.yaml"
  rm "$output_dir/repli.yaml"
  approve "repli new model --exact"
  approve "repli new model2 --exact"
  rm "$output_dir/repli.yaml"

  context "with interactive menu"
    reset_state
    add_templates
    approve "echo 2 | repli new"
    reset_state
    add_templates
    approve "echo 2 | repli new model"

