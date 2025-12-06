validate_model_name() {
  if ! [[ "$1" =~ ^[^/]+/[^/]+$ ]]; then
    echo "must be in the form of author/model"
  fi
}
