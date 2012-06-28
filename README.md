
# your_server.json

    {
      "run_list": [
        "recipe[your_server]"
      ],
    
      "default_user": {
        "name":     "your_account_name",
        "password": "your_hashed_password",
        "home_dir": "path_to_home"
      }
    }

# sync files to remote servers

    rsync -r . ${1}:/root

# run chef-solo

    chef-solo -c solo.rb -j your_server.json


