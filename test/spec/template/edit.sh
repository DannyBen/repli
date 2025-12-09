describe "templates edit"
  reset_state
  approve "repli template edit --help"
  approve "repli template edit"
  approve "repli template edit missing-template"
  add_templates
  approve "repli template edit model1"

  context "interactive template select"
    add_templates
    approve "echo 1 | repli template edit mod"

