describe "templates list"
  reset_state
  approve "repli template list --help"
  approve "repli template list" "repli_templates_list@empty"
  add_templates
  approve "repli template list"
  approve "repli template list model"
  approve "repli template list nosuchmodel"

