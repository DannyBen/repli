describe "files upload"
  reset_state
  approve "repli files upload --help"
  approve "repli files upload --help"
  approve "repli files upload fixtures/images/sample.jpg"
  approve "repli files upload fixtures/images/sample.jpg" "repli_files_upload_fixtures_sample_jpg@again"
  rm files.ini
