describe "templates new"
  reset_state
  approve "repli templates new --help"
  approve "repli templates new"
  approve "repli templates new google/nano-banana"
  approve "repli templates new google/nano-banana" "repli_templates_new_google_nano_banana@exist"
  approve "repli templates new google/nano-banana --force"
  approve "repli templates new google/nano-banana --name banana"
  approve "repli templates new not/found"
  approve "cat $REPLI_TEMPLATES_DIR/banana.yaml" "cat_banana_yaml"
  approve "ls $REPLI_TEMPLATES_DIR"

