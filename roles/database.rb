name "database"
description "Database Server role"

override_attributes(
  "mongodb" => {
    "install_method" => "10gen",
    "config" => { "auth" => true },
    "admin" => {
      "username" => "admin",
      "password" => "password",
      "roles"    => ["root", "userAdminAnyDatabase", "dbAdminAnyDatabase"],
      "database" => "admin"
    },
    "users" => [
      {
        :username => "myuser",
        :password => "password",
        :roles    => ["dbOwner", "readWrite"],
        :database => "mydatabase"
      }
    ]
  }
)

all_env = [
  "recipe[mongodb]",
  "recipe[mongodb::user_management]"
]

run_list(all_env)
