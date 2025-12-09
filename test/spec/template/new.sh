describe "templates new"
  reset_state
  approve "repli template new --help"
  approve "repli template new"
  approve "repli template new google/nano-banana"
  approve "repli template new google/nano-banana" "repli_templates_new_google_nano_banana@exist"
  approve "repli template new google/nano-banana --force"
  approve "repli template new google/nano-banana --name banana"
  approve "repli template new not/found"
  approve "cat $REPLI_TEMPLATES_DIR/banana.yaml" "cat_banana_yaml"
  approve "ls $REPLI_TEMPLATES_DIR"

