describe "templates show"
  reset_state
  approve "repli templates show --help"
  approve "repli templates show"
  approve "repli templates show missing-template"
  add_templates
  approve "repli templates show model1"

