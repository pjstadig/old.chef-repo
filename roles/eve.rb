name "eve"
description "Configures eve."
# List of recipes and roles to apply. Requires Chef 0.8, earlier versions use 'recipes()'.
run_list("role[chef-client]", "recipe[users::sysadmins]", "recipe[sudo]", "recipe[eve]")
# Attributes applied if the node doesn't have it set already.
#default_attributes()
# Attributes applied no matter what the node has set already.
#override_attributes()
