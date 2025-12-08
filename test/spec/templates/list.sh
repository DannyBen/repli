describe "templates list"
  reset_state
  approve "repli templates list --help"
  approve "repli templates list" "repli_templates_list@empty"
  add_templates
  approve "repli templates list"
  approve "repli templates list model"
  approve "repli templates list nosuchmodel"

