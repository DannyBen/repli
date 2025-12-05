#!/usr/bin/env ruby
require "sinatra"
require "json"

MOCK_ROOT = File.expand_path("mocks", __dir__)

set :bind, "0.0.0.0"
set :port, 3000
set :server, :puma
set :environment, :production

before do
  content_type "application/json"
end

helpers do
  def candidates(path, method)
    clean      = path.gsub(%r{/$}, "")     # remove trailing slash
    base       = File.basename(clean)      # last part of path
    dir        = File.dirname(clean)       # everything above basename
    method_tag = method.downcase           # "post", "get", etc.

    dir = "" if dir == "." # Normalize dir = "." → ""
    full_dir = dir.empty? ? MOCK_ROOT : "#{MOCK_ROOT}/#{dir}"

    [
      "#{full_dir}/#{method_tag}-#{base}.json",       # get-users.json
      "#{full_dir}/#{base}/#{method_tag}.json",       # users/get.json
      "#{full_dir}/#{base}.json",                     # users.json
    ]
  end

  # Return the first existing file among candidates
  def resolve_mock(path, method)
    candidates(path, method).find { |file| File.file?(file) }
  end
end

# Route all HTTP verbs
%w[GET POST PUT PATCH DELETE OPTIONS].each do |verb|
  send(verb.downcase, "/*") do
    req_path = params["splat"].first
    file = resolve_mock(req_path, request.request_method)

    if file
      return File.read(file)
    else
      status 404
      return JSON.dump(error: "No mock for #{request.request_method} #{request.path}")
    end
  end
end
