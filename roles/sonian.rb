name "sonian"
description "Configures sonian."
# List of recipes and roles to apply. Requires Chef 0.8, earlier versions use 'recipes()'.
run_list("role[chef-client]", "recipe[sonian]", "recipe[sudo]")
# Attributes applied if the node doesn't have it set already.
default_attributes "authorization" => {
  "sudo" => {
    "passwordless" => true,
    "users" => ["vagrant"]
  },
}
# Attributes applied no matter what the node has set already.
#override_attributes()
