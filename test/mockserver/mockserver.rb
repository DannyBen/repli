#!/usr/bin/env ruby
require "sinatra"
require "json"

# Root folder for your mock fixtures
MOCK_ROOT = File.expand_path("mocks", __dir__)

set :bind, "0.0.0.0"
set :port, 3000
set :server, :puma
set :environment, :production

before do
  content_type "application/json"
end

helpers do
  def json_file_for(path)
    clean = path.gsub(%r{/$}, "")  # Remove trailing slash

    # Try exact match: /foo/bar → mocks/foo/bar.json
    try = File.join MOCK_ROOT, clean + ".json"
    return try if File.file? try

    # Try directory index: /foo/bar/ → mocks/foo/bar/index.json
    idx = File.join MOCK_ROOT, clean, "index.json"
    return idx if File.file? idx

    nil
  end
end

get "/*" do
  req_path = params["splat"].first
  file = json_file_for req_path
  
  return File.read file if file

  status 404
  return JSON.dump error: "No mock for #{request.path}"
end
