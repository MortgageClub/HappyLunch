VCR.configure do |c|
  c.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  c.hook_into :webmock # or :fakeweb
  c.ignore_localhost = true
  c.debug_logger = File.open("vcr.log", "w")
  c.allow_http_connections_when_no_cassette = true
  c.filter_sensitive_data("<SLACK_TOKEN>") { ENV["SLACK_TOKEN"] }
  c.filter_sensitive_data("<OUTGOING_TOKEN>") { ENV["OUTGOING_TOKEN"] }
end
