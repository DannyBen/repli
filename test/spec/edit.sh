describe "edit"
  reset_state
  approve "repli edit --help"
  approve "repli edit" "repli_edit@empty"
  add_repli_yaml
  approve "repli edit"
  mv repli.yaml custom.yaml
  approve "repli edit -u custom.yaml"

