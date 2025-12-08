describe "templates delete"
  reset_state
  approve "repli templates delete --help"
  approve "repli templates delete"
  approve "repli templates delete missing-template"
  add_templates
  approve "repli templates delete model1"

