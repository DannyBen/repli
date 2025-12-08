describe "templates edit"
  reset_state
  approve "repli templates edit --help"
  approve "repli templates edit"
  approve "repli templates edit missing-template"
  add_templates
  approve "repli templates edit model1"

