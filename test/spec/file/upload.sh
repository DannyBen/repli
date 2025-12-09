describe "files upload"
  reset_state
  approve "repli file upload --help"
  approve "repli file upload --help"
  approve "repli file upload fixtures/images/sample.jpg"
  approve "repli file upload fixtures/images/sample.jpg" "repli_files_upload_fixtures_sample_jpg@again"
  rm "$output_dir/files.ini"
