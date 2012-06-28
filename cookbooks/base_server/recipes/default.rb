# -*- coding: utf-8 -*-

# ERBテンプレートで日本語を使用する際は以下の指定が必要
Encoding.default_external = "UTF-8"

#
# Cookbook Name:: base_server
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# ----------------------------------------------------------------------
# Example of intalling packages
# ----------------------------------------------------------------------
package 'atop' do
  action  [ :install ]
end

# ----------------------------------------------------------------------
# Example of removing packages
# ----------------------------------------------------------------------
package 'mysql-libs' do
  action  [ :remove ]
end

#['htop', 'screen', 'telnet', 'nc', 'tree'].each do |pkg|
#  package pkg
#end


# ----------------------------------------------------------------------
# Example of managing system service
# ----------------------------------------------------------------------
service 'ntpd' do
  action  [ :disable, :stop ]
end


# ----------------------------------------------------------------------
# Example of creating a new user
# ----------------------------------------------------------------------
user node[:default_user][:name] do
  password node[:default_user][:password]
  home node[:default_user][:home_dir]
  supports manage_home: true
  shell '/bin/bash'
end


# ----------------------------------------------------------------------
# Example of creating a new directory
# ----------------------------------------------------------------------
directory "#{node[:default_user][:home_dir]}/isogai" do
  owner node[:default_user][:name]
  group node[:default_user][:name]
  mode '0700'
  action :create
end


# ----------------------------------------------------------------------
# Example of cookbook_file
# ----------------------------------------------------------------------
["gemrc", "screenrc", "vimrc"].each do |file_name|
  cookbook_file "#{node[:default_user][:home_dir]}/.#{file_name}" do
    owner node[:default_user][:name]
    group node[:default_user][:name]
    source file_name
    mode '0644'
    action :create
  end
end


# ----------------------------------------------------------------------
# Example of template
# ----------------------------------------------------------------------
["diary.txt"].each do |file_name|
  template "#{node[:default_user][:home_dir]}/#{file_name}" do
    owner node[:default_user][:name]
    group node[:default_user][:name]
    source "#{file_name}.erb"

    variables({
      author: "磯貝",
      at:     "7時",
      action: "家に帰った"
    })

    mode '0600'
    action :create
  end
end


# ----------------------------------------------------------------------
# Example of syncing source code with git
# ----------------------------------------------------------------------
git "/home/#{node[:default_user][:name]}/erlproxy" do
  repository  "git://github.com/devkato/erlproxy.git"
  revision    "master"
  user        node[:default_user][:name]
  group       node[:default_user][:name]
  action      :sync
end

