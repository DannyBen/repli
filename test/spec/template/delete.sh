describe "templates delete"
  reset_state
  approve "repli template delete --help"
  approve "repli template delete"
  approve "repli template delete missing-template"
  add_templates
  approve "repli template delete model1"

  context "interactive template select"
    add_templates
    approve "echo 1 | repli template delete mod"
