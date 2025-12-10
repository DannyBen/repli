describe "templates list"
  reset_state
  approve "repli template grep --help"
  approve "repli template grep"
  add_templates
  approve "repli template grep 2:3"
  cp fixtures/templates/basic-grep.yaml "$REPLI_TEMPLATES_DIR/template-with-21x9.yaml"
  approve "repli template grep 21:9"

