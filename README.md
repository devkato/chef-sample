
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

to create hashed password ...

    openssl passwd -1
    (type your password)

and paste the result to "your_hashed_password".

# sync files to remote servers as root

    rsync -r . your-server:/root

# run chef-solo

    chef-solo -c solo.rb -j your_server.json


