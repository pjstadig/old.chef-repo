CHEF_HOME = File.expand_path(ENV["HOME"] + "/.chef")
CHEF_REPO = File.expand_path(File.dirname(__FILE__) + "/..")

log_level                     :info
log_location                  STDOUT
node_name                     "pjstadig"
client_key                    "#{CHEF_HOME}/pjstadig.pem"
validation_client_name        "pjstadig-validator"
validation_key                "#{CHEF_HOME}/pjstadig-validator.pem"
chef_server_url               "https://api.opscode.com/organizations/pjstadig"
cache_type                    "BasicFile"
cache_options(:path => "#{CHEF_HOME}/checksums")
cookbook_path                 ["#{CHEF_REPO}/cookbooks"]
cookbook_copyright            "Paul Stadig"
cookbook_email                "paul@stadig.name"
cookbook_license              "apachev2"

AWS_CONFIG = ENV["HOME"] + "/.aws.yml"
if File.exists?(AWS_CONFIG)
  AWS = YAML.load(File.read(AWS_CONFIG))
  knife[:aws_access_key_id]     = AWS["AWS_ACCESS_KEY_ID"]
  knife[:aws_secret_access_key] = AWS["AWS_SECRET_ACCESS_KEY"]
end
