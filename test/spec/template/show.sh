describe "templates show"
  reset_state
  approve "repli template show --help"
  approve "repli template show"
  approve "repli template show missing-template"
  add_templates
  approve "repli template show mod"
