name "chef-client"
description "Installs the chef-client service."
# List of recipes and roles to apply. Requires Chef 0.8, earlier versions use 'recipes()'.
run_list("recipe[chef-client::service]")
# Attributes applied if the node doesn't have it set already.
default_attributes "chef_client" => {
  "init_style" => "upstart"
}
# Attributes applied no matter what the node has set already.
#override_attributes()
